import { config } from "dotenv";
config();

export default {
  port: process.env.PORT || 3000,
  dbUser: process.env.DB_USER || "sa",
  dbPassword: process.env.DB_PASSWORD || "Sergio29_",
  dbServer: process.env.DB_SERVER || "DESKTOP-43I13M5",
  dbDatabase: process.env.DB_DATABASE || "AdventureWorks2019",
};
