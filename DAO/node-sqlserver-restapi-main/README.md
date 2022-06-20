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

GET - {api}/products - Obtiene todos los productos
GET - {api}/products/count - Obtiene el total cuantificado de los productos
DELETE - {api}/products/:id - Borra un producto por su id
PUT - {api}/products/:id - Actualiza la informacion de un producto por su id
