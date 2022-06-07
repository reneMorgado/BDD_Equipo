const sql = require('mssql')

const dbSettings = {
  user: process.env.DBUSER || 'NodeUser',
  password: process.env.DBPASS || 'Pass123_',
  server: process.env.DBSERVER || 'localhost',
  database: process.env.DBNAME || 'AdventureWorks2019',
  options: {
    encrypt: true,
    trustServerCertificate: true,
  },
};

const connectDB = async () => {
  try {
    const pool = await sql.connect(dbSettings);
    return pool;
  } catch (error) {
    console.error(error);
  }
};

module.exports = { sql, connectDB };