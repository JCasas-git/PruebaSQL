/**************************************************************************************
Tabla: 
AuditoriaAccesos

Descripción: 
Registra cada vez que un usuario accede a información sensible.

¿Para qué sirve?: 
Permite llevar un historial de accesos para auditoría, seguridad y cumplimiento. 
Guarda quién accedió, cuándo, qué acción realizó, sobre qué tabla y qué script ejecutó, 
lo cual es clave en sistemas con manejo de datos confidenciales como la nómina.

Autor:          [Julian Casas]
Fecha creación: [05/05/2025]
**************************************************************************************/
CREATE TABLE AuditoriaAccesos (
    ID_Auditoria INT IDENTITY PRIMARY KEY,         -- Clave primaria autoincremental
    UserName VARCHAR(100),                         -- Usuario que ejecutó la acción
    Fecha DATETIME DEFAULT GETDATE(),              -- Fecha y hora de la consulta
    Accion VARCHAR(10),                            -- Tipo de acción (por ahora solo 'SELECT')
    Tabla VARCHAR(100),                            -- Tabla sobre la que se ejecutó la acción
    ScriptEjecutado VARCHAR(MAX)                   -- Script SQL que fue ejecutado
);
