/**************************************************************************************
Tabla: 
Usuario

Descripción: 
Contiene la información de los usuarios del sistema y su relación con los roles.

¿Para qué sirve?: 
Asocia cada usuario a un rol específico, permitiendo así la aplicación de permisos y 
restricciones definidos para su perfil. Es la base del sistema de autenticación y autorización.

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/
CREATE TABLE Usuario (
    ID_User INT PRIMARY KEY IDENTITY(1,1),      -- Clave primaria autoincremental
    UserName VARCHAR(100) NOT NULL UNIQUE,      -- Nombre de usuario, debe ser único
    ID_Rol INT NOT NULL,                        -- Clave foránea al rol asignado

    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol) -- Relación con la tabla Rol
);