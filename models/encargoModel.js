import Conexion from '../instanciadb/Conexion.js';

class EncargoModel {
    static async crear(data) {
        const pool = Conexion.getInstancia().pool;
        const { fk_solicitante, fk_ubicacion_georrefencial, descripción, descripcion_ubicacion, remuneración } = data;

        const [result] = await pool.query(
            `INSERT INTO encargo (fk_solicitante, fk_ubicacion_georefencial, descripción, descripcion_ubicacion, remuneración, estado_actual) 
             VALUES (?, ?, ?, ?, ?, 'disponible')`,
            [fk_solicitante, fk_ubicacion_georrefencial || null, descripción, descripcion_ubicacion || null, remuneración]
        );

        return result.insertId;
    }

    static async obtenerDisponibles() {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT * FROM encargo WHERE estado_actual = 'disponible'`
        );
        return rows;
    }


    static async obtenerPorSolicitante(idHabitante) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT * FROM encargo WHERE fk_solicitante = ?`,
            [idHabitante]
        );
        return rows;
    }


    static async obtenerEntregadosComoDomiciliario(idHabitante) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT e.* FROM encargo e
             JOIN aceptacion a ON e.id_encargo = a.fk_encargo
             WHERE a.fk_domiciliario = ? AND e.estado_actual = 'entregado'`,
            [idHabitante]
        );
        return rows;
    }

}

export default EncargoModel;