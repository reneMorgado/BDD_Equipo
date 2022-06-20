import { getConnection, querys, sql } from "../database";

export const getEmpleado = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getOrderForTerritory);
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const getOrdenesNorthAmerica = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getClienteNorteAmerica);
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const getOfertasBikes = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getBikes);
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const getProducts = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getProduct);
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const getClientes = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getClientes);
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const updateSubcategory = async (req, res) => {
  
  try {
    const{productId, subcategoriaID} = req.body;
    const pool = await getConnection();
    const result= await pool.request()
      .input("productId", productId)
      .input("subcategoriaId", subcategoriaID)
      .execute('sp_ActualizarSubcatego');
    console.log(result)
    console.log(req.body);
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};
