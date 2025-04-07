/*************************************************************************************
Nombre:         sp_Consultar_Datos
Descripción:    Procedimiento almacenado que permite consultar datos de la tabla 'Nomina'
                según los permisos del usuario autenticado. Realiza auditoría del acceso.

Parámetros:
    @UserName  - Nombre de usuario que realiza la consulta.
    @Tabla     - Nombre de la tabla sobre la cual se desea consultar información.

Tablas involucradas:
    - Usuario
    - Permisos
    - Nomina
    - CentroCosto
    - AuditoriaAccesos

Restricciones:
    - Solo se permite acceso a la tabla 'Nomina'.
    - El usuario debe tener permisos explícitos de lectura (Can_Read).
    - Se audita toda consulta realizada.

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/

CREATE PROCEDURE sp_Consultar_Datos
    @UserName VARCHAR(100),
    @Tabla VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------------------
    -- Declaración de variables
    ------------------------------------------------------------------------
    DECLARE 
        @ID_User INT,
        @ID_Rol INT,
        @Tipo_Usuario INT,
        @CanRead BIT,
        @SQLCommand NVARCHAR(MAX),
        @CentroLider INT;

    ------------------------------------------------------------------------
    -- 1. Obtener ID de usuario y rol
    ------------------------------------------------------------------------
    SELECT @ID_User = ID_User, @ID_Rol = ID_Rol
    FROM Usuario
    WHERE UserName = @UserName;

    IF @ID_User IS NULL
    BEGIN
        RAISERROR('Usuario no encontrado.', 16, 1);
        RETURN;
    END

    ------------------------------------------------------------------------
    -- 2. Verificar permisos del rol sobre la tabla
    ------------------------------------------------------------------------
    SELECT 
        @Tipo_Usuario = Tipo_Usuario,
        @CanRead = Can_Read
    FROM Permisos
    WHERE Tabla = @Tabla AND ID_Rol = @ID_Rol;

    IF @Tipo_Usuario IS NULL
    BEGIN
        RAISERROR('No tiene permisos sobre esta tabla.', 16, 1);
        RETURN;
    END

    IF @CanRead = 0
    BEGIN
        RAISERROR('No tiene permiso de lectura.', 16, 1);
        RETURN;
    END

    ------------------------------------------------------------------------
    -- 3. Validar tabla soportada
    ------------------------------------------------------------------------
    IF @Tabla = 'Nomina'
    BEGIN
        --------------------------------------------------------------------
        -- 4. Generar SELECT según tipo de usuario
        --------------------------------------------------------------------
        IF @Tipo_Usuario IN (0, 1) -- Admin o Nómina
        BEGIN
            SET @SQLCommand = N'
                SELECT 
                    u.UserName,
                    cc.Nombre AS CentroCosto,
                    n.Salario,
                    n.Bonificacion,
                    n.Deducibles,
                    (n.Salario + n.Bonificacion - n.Deducibles) AS Salario_Neto
                FROM Nomina n
                INNER JOIN Usuario u ON n.ID_User = u.ID_User
                INNER JOIN CentroCosto cc ON n.ID_Centro = cc.ID_Centro
            ';
        END
        ELSE IF @Tipo_Usuario = 2 -- Líder
        BEGIN
            -- Obtener el centro de costo asociado al líder
            SELECT TOP 1 @CentroLider = n.ID_Centro
            FROM Nomina n
            WHERE n.ID_User = @ID_User;

            SET @SQLCommand = N'
                SELECT 
                    u.UserName,
                    cc.Nombre AS CentroCosto,
                    n.Salario,
                    n.Bonificacion,
                    n.Deducibles,
                    (n.Salario + n.Bonificacion - n.Deducibles) AS Salario_Neto
                FROM Nomina n
                INNER JOIN Usuario u ON n.ID_User = u.ID_User
                INNER JOIN CentroCosto cc ON n.ID_Centro = cc.ID_Centro
                WHERE n.ID_Centro = ' + CAST(@CentroLider AS NVARCHAR);
        END
        ELSE IF @Tipo_Usuario = 3 -- Empleado
        BEGIN
            SET @SQLCommand = N'
                SELECT 
                    u.UserName,
                    cc.Nombre AS CentroCosto,
                    n.Salario,
                    n.Bonificacion,
                    n.Deducibles,
                    (n.Salario + n.Bonificacion - n.Deducibles) AS Salario_Neto
                FROM Nomina n
                INNER JOIN Usuario u ON n.ID_User = u.ID_User
                INNER JOIN CentroCosto cc ON n.ID_Centro = cc.ID_Centro
                WHERE n.ID_User = ' + CAST(@ID_User AS NVARCHAR);
        END
        ELSE
        BEGIN
            RAISERROR('Tipo de usuario no válido.', 16, 1);
            RETURN;
        END

        --------------------------------------------------------------------
        -- 5. Ejecutar consulta dinámica
        --------------------------------------------------------------------
        EXEC sp_executesql @SQLCommand;

        --------------------------------------------------------------------
        -- 6. Registrar auditoría de la consulta
        --------------------------------------------------------------------
        INSERT INTO AuditoriaAccesos (UserName, Fecha, Accion, Tabla, ScriptEjecutado)
        VALUES (@UserName, GETDATE(), 'SELECT', @Tabla, @SQLCommand);
    END
    ELSE
    BEGIN
        RAISERROR('Tabla no soportada actualmente.', 16, 1);
        RETURN;
    END
END
