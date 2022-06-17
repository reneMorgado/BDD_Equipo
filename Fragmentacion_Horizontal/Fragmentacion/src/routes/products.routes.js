import { Router } from "express";
import {
  getEmpleado,
  getOrdenesNorthAmerica,
  getOfertasBikes,
  getProducts,
  getClientes,
  updateSubcategory
} from "../controllers/products.controller";

const router = Router();

router.get("/empleados", getEmpleado);
router.get("/ordenes", getOrdenesNorthAmerica);
router.get("/ofertas", getOfertasBikes );
router.get("/productos", getProducts);
router.get("/clientes", getClientes);
router.put("/subcategoria", updateSubcategory)



export default router;
