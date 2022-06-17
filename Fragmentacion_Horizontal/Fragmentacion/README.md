# Node & MSSQL Server API
nodejs and Microsoft SQL Server Database REST API

## Variables de entorno a editar

DB_USER = youruser
DB_PASSWORD = yourpassword
DB_SERVER = localhost
DB_DATABASE = yourdatabase

En el archivo config.js

## Requerimientos

NodeJS en una versión superior a la 12

Instancia de base de datos SQL Server

## Procediemiento para correr

Debemos ejecutar el comando 

```bash
npm i 
```

Para instalar todas las dependencias del proyecto, posteriormente para levantar el servidor debemos correr

```bash
npm run dev
```

Y con eso podremos lanzar peticiones a las rutas indicadas

- {api}/empleados - Encargada de obtener los empleados desde la base de datos
- {api}//ordenes - Encargada de obtener los datos del cliente con más ordenes solicitadas en norte américa desde la base de datos
- {api}/ofertas - Encargada de obtener las ofertas que tienen los productos de la categoría bikes desde la base de datos
- {api}/productos - Encargada de obtener los tres productos menos solicitados en europa desde la base de datos
- {api}/clientes - Encargada de listar los clientes del territorio 1 y 4 que no tengan asociado un valor en personId
- {api}/subcategoria - Encargada de actualizar la subcategoría de los productos con productId del 1 al 4 a la subcategoría valida para el tipo de producto en la base de datos
