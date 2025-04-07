/**************************************************************************************
Tabla: 
Rol

Descripción: 
Almacena los distintos roles que pueden ser asignados a los usuarios.

¿Para qué sirve?: 
Define las categorías de usuario (como administrador, rrhh, nómina, director, líder, especialista, analista), 
que posteriormente se usan para asignar permisos y controlar el acceso a funcionalidades específicas del sistema.

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/
CREATE TABLE Rol (
    ID_Rol INT PRIMARY KEY IDENTITY(1,1),      -- Clave primaria autoincremental
    Nombre VARCHAR(100) NOT NULL,              -- Nombre descriptivo del rol (ej. 'Administrador')
    Cod_Rol VARCHAR(50) NOT NULL UNIQUE        -- Código único del rol (ej. 'ADMIN')
);