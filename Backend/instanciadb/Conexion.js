import mysql from "mysql2/promise";
import "../config/env.js";

class Conexion {
  static #instancia = null;

  constructor() {
    if (Conexion.#instancia) return Conexion.#instancia;
    
    this.pool = mysql.createPool({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      port: process.env.DB_PORT,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    });
  
  }
  static getInstancia(){
    if(!Conexion.#instancia){
      Conexion.#instancia = new Conexion()
    }
    return Conexion.#instancia
  }

  async pruebaConexion() {
    try {
      const connection = await this.pool.getConnection();
      console.log("CONEXION A LA BASE DE DATOS EXITOSA");
      connection.release();
    } catch (error) {
      console.error("NO SE PUDO CONECTAR CON LA BASE DE DATOS", error.message);
    }
  }
}
export default Conexion

