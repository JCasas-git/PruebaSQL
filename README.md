# PruebaSQL
🗃️ Descripción del Repositorio – Sistema de Control de Acceso y Consultas Dinámicas
Este repositorio contiene la estructura base de una solución para gestionar el acceso controlado y auditable a información sensible de una base de datos, como datos de nómina, a través de un procedimiento almacenado (Stored Procedure) dinámico en SQL Server. Además, incluye la integración con un backend desarrollado en Django REST Framework para su consumo por aplicaciones externas.

🧱 Estructura del Proyecto
📌 Base de Datos (SQL Server)
Contiene el script de creación de las siguientes entidades:

Rol: Define los roles del sistema (Administrador, Nómina, Líder, Empleado).

Usuario: Registro de usuarios del sistema, con su respectivo rol.

Permisos: Control de accesos granulares por tabla y tipo de operación (CRUD), por rol.

CentroCosto: Representa unidades organizacionales dentro de la empresa.

Nomina: Información financiera de los empleados.

AuditoriaAccesos: Registra cada consulta ejecutada, con metainformación para trazabilidad.

🧠 Procedimiento Almacenado: sp_Consultar_Datos
Stored Procedure dinámico que:

Valida los permisos del usuario autenticado.

Permite realizar un SELECT solo si el rol y tipo de usuario lo permite.

Filtra los datos de la tabla Nomina según el tipo de usuario (acceso total, por centro o individual).

Registra en la tabla AuditoriaAccesos cada ejecución exitosa.

Incluye documentación y validaciones robustas.

⚙️ Backend: Django REST Framework
El proyecto Django implementa una API para:

Autenticar usuarios.

Enviar parámetros a sp_Consultar_Datos (usuario, tabla).

Devolver resultados al frontend o cliente externo.


🚀 Objetivo
Proveer una arquitectura segura y escalable para el acceso por roles a información sensible, con trazabilidad y control a nivel de tabla, registro y operación. Ideal para empresas que manejan múltiples centros de costo o estructuras jerárquicas.
