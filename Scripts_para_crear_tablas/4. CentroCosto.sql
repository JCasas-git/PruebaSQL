/**************************************************************************************
Tabla: 
CentroCosto

Descripción: 
Registra los diferentes centros de costos de la organización.

¿Para qué sirve?: 
Agrupa a los usuarios o empleados bajo una unidad organizacional, 
útil para generar reportes financieros, dividir responsabilidades 
y filtrar accesos según el área de pertenencia.

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/
CREATE TABLE CentroCosto (
    ID_Centro INT PRIMARY KEY IDENTITY(1,1),       -- Clave primaria autoincremental
    Nombre VARCHAR(100) NOT NULL UNIQUE            -- Nombre único del centro de costos
);