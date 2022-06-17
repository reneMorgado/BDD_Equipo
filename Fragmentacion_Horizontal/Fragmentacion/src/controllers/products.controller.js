import { getConnection, querys, sql } from "../database";

/**
 * @function getEmpleado - Encargada de obtener los empleados desde la base de datos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
export const getEmpleado = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getOrderForTerritory);
    return res.json(result.recordset);
  } catch (error) {
    return res.status(500).send(error.message);
  }
};

/**
 * @function getOrdenesNorthAmerica - Encargada de obtener los datos del cliente con más 
 *                                    ordenes solicitadas en norte américa desde la base de datos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
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

/**
 * @function getOfertasBikes - Encargada de obtener 
 *                             las ofertas que tienen los productos de la categoría bikes 
 *                             desde la base de datos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
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

/**
 * @function getProducts - Encargada de obtener los tres productos menos solicitados
 *                         en europa desde la base de datos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
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

/**
 * @function getClientes - Encargada de listar los clientes del territorio 1 y 4 
 *                         que no tengan asociado un valor en personId
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
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

/**
 * @function updateSubcategory - Encargada de actualizar la subcategoría de los productos 
 *                               con productId del 1 al 4 a la subcategoría valida
 *                               para el tipo de producto en la base de datos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
export const updateSubcategory = async (req, res) => {
  
  try {
    const{productId, subcategoriaID} = req.body;
    const pool = await getConnection();
    const result= await pool.request()
      .input("Correo", productId)
      .input("", subcategoriaID)
      .execute('sp_ActualizaCorreo');
    console.log(result)
    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};
