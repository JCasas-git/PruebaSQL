/**************************************************************************************
Tabla: 
Nomina

Descripción: 
Contiene los registros de pago y compensación para cada usuario.

¿Para qué sirve?: 
Permite almacenar y consultar información salarial como salario base, 
bonificaciones y deducciones. Esta tabla es consultada con control 
de acceso personalizado, de acuerdo al rol y jerarquía del usuario.

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/
CREATE TABLE Nomina (
    ID_Pago INT PRIMARY KEY IDENTITY(1,1),         -- Clave primaria autoincremental
    ID_User INT NOT NULL,                          -- Clave foránea al usuario
    ID_Centro INT NOT NULL,                        -- Clave foránea al centro de costos
    Salario DECIMAL(10,2) NOT NULL,                -- Sueldo base del empleado
    Bonificacion DECIMAL(10,2) DEFAULT 0,          -- Bonos adicionales
    Deducibles DECIMAL(10,2) DEFAULT 0,            -- Descuentos o deducciones

    FOREIGN KEY (ID_User) REFERENCES Usuario(ID_User),        -- Relación con Usuario
    FOREIGN KEY (ID_Centro) REFERENCES CentroCosto(ID_Centro) -- Relación con CentroCosto
);
