import sql from "mssql";
import config from "../config";

// Función de configuración para la conexión a la base de datos
export const dbSettings = {
  user: config.dbUser,
  password: config.dbPassword,
  server: config.dbServer,
  database: config.dbDatabase,
  options: {
    encrypt: true, // for azure
    trustServerCertificate: true, // change to true for local dev / self-signed certs
  },
};

/**
 * @function getConnection - Encargada de hacer la conexión con la base de datos
 * @returns { Object } pool - Objeto respuesta de conexión
 */
export const getConnection = async () => {
  try {
    const pool = await sql.connect(dbSettings);
    return pool;
  } catch (error) {
    console.error(error);
  }
};

export { sql };
