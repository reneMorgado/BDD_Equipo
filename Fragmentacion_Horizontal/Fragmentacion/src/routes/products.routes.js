import { Router } from "express";

// Importa los controladores para asignarlos a rutas específicas
import {
  getEmpleado,
  getOrdenesNorthAmerica,
  getOfertasBikes,
  getProducts,
  getClientes,
  updateSubcategory
} from "../controllers/products.controller";

// Genera un router para manejo de rutas
const router = Router();

// Se asgina una función de comportamiento a cada ruta
router.get("/empleados", getEmpleado);
router.get("/ordenes", getOrdenesNorthAmerica);
router.get("/ofertas", getOfertasBikes );
router.get("/productos", getProducts);
router.get("/clientes", getClientes);
router.put("/subcategoria", updateSubcategory)

export default router;
