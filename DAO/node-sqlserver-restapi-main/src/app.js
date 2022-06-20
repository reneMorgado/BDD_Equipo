import express from "express";
import cors from "cors";
import productRoutes from "./routes/products.routes";
import morgan from "morgan";

import config from "./config";

// Configuramos la instacia de express
const app = express();

// Seteamos el pueto a usar
app.set("port", config.port);

// Configuramos middlewares para cors, desarrollo y lectura del cuerpo json
app.use(cors());
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// Seteamos la ruta principal de la aplicación
app.use("/api", productRoutes);

export default app;
