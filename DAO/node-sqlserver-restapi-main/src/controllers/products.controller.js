import { getConnection, querys, sql } from "../database";

/**
 * @function getProducts - Obtiene todos los productos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
export const getProducts = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query(querys.getAllProducts);
    return res.json(result.recordset);
  } catch (error) {
    return res.status(500).send(error.message);
  }
};

/**
 * @function deleteProductById - Borra un producto por su id
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
export const deleteProductById = async (req, res) => {
  try {
    const pool = await getConnection();

    const result = await pool
      .request()
      .input("id", req.params.id)
      .query(querys.deleteProduct);
    if (result.rowsAffected[0] === 0) return res.sendStatus(404);
    return res.sendStatus(204);
  } catch (error) {
    return res.status(500).send(error.message);
  }
};

/**
 * @function getTotalProducts - Obtiene el total cuantificado de los productos
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
export const getTotalProducts = async (req, res) => {
  const pool = await getConnection();

  const result = await pool.request().query(querys.getTotalProducts);
  console.log(result);
  return res.json(result.recordset[0][""]);
};

/**
 * @function updateProductById - Actualiza la informacion de un producto por su id
 * @param { Object } req - Objeto de la petición realizada
 * @param { Object } res - Objeto de la respuesta que dará la petición
 * @returns { Object } res - Objeto de la respuesta que dará la petición con los datos requeridos
 */
export const updateProductById = async (req, res) => {
  
  try {
    const{Correo} = req.body;
    const pool = await getConnection();
    const result= await pool.request()
      .input("Correo", Correo)
      .execute('sp_ActualizaCorreo');
    console.log(result)
    return res.json(result.recordset);
  } catch (error) {
    return res.status(500).send(error.message);
  }
};
