import app from "./app";

// Ponemos al servidor a la escucha en el puerto indicado
app.listen(app.get("port"));

// Nos dice que el servidor está corriendo
console.log("Server on port", app.get("port"));
