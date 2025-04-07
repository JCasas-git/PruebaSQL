/**************************************************************************************
Tabla: 
Permisos

Descripción: 
Define los permisos de acceso de cada rol a diferentes tablas del sistema.

¿Para qué sirve?: 
Permite definir de forma granular qué acciones (crear, leer, actualizar, eliminar) puede 
realizar un usuario en cada tabla. Además, establece si un usuario puede ver toda la información 
o solo una parte (según su tipo: Admin, Nomina, Lider, Empleado).

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/
CREATE TABLE Permisos (
    ID_Permiso INT PRIMARY KEY IDENTITY(1,1),       -- Clave primaria autoincremental
    Tabla VARCHAR(100) NOT NULL,                    -- Nombre de la tabla a la que aplica el permiso
    Can_Create BIT NOT NULL DEFAULT 0,              -- Permiso para realizar INSERT
    Can_Read BIT NOT NULL DEFAULT 0,                -- Permiso para realizar SELECT
    Can_Update BIT NOT NULL DEFAULT 0,              -- Permiso para realizar UPDATE
    Can_Delete BIT NOT NULL DEFAULT 0,              -- Permiso para realizar DELETE
    ID_Rol INT NOT NULL,                            -- Clave foránea al rol
    Tipo_Usuario INT NOT NULL CHECK (Tipo_Usuario IN (0,1,2,3)), -- Tipo de usuario (0=Admin, 1=Nomina, 2=Lider, 3=Empleado)

    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol)     -- Relación con la tabla Rol
);