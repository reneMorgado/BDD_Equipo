import { config } from "dotenv";

// Configuración para leer variables de entorno
config();

// Se exportan los datos de configuración obtenidos del .env o seteados por defecto
export default {
  port: process.env.PORT || 3000,
  dbUser: process.env.DB_USER || "sa",
  dbPassword: process.env.DB_PASSWORD || "Sergio29_",
  dbServer: process.env.DB_SERVER || "DESKTOP-43I13M5",
  dbDatabase: process.env.DB_DATABASE || "AdventureWorks2019",
};
