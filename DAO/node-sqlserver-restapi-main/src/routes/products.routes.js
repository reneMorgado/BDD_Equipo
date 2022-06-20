import { Router } from "express";

// Importa los controladores para asignarlos a rutas específicas
import {
  getProducts,
  createNewProduct,
  getProductById,
  deleteProductById,
  getTotalProducts,
  updateProductById,
} from "../controllers/products.controller";

// Genera un router para manejo de rutas
const router = Router();

// Se asigna una función de comportamiento a cada ruta
router.get("/products", getProducts);
router.get("/products/count", getTotalProducts);
router.delete("/products/:id", deleteProductById);
router.put("/products/:id", updateProductById);

export default router;
