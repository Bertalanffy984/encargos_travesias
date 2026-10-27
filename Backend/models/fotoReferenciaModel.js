import Conexion from '../instanciadb/Conexion.js';

class FotoReferenciaModel {
    static async crear(fk_encargo, enlace_foto) {
        const pool = Conexion.getInstancia().pool;
        const [result] = await pool.query(
            `INSERT INTO fotos_referencia (fk_encargo, enlace_foto) VALUES (?, ?)`,
            [fk_encargo, enlace_foto]
        );
        return result.insertId;
    }

    static async obtenerPorEncargo(fk_encargo) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT * FROM fotos_referencia WHERE fk_encargo = ?`,
            [fk_encargo]
        );
        return rows;
    }
    
    static async actualizar(id, enlace_foto) {
        const pool = Conexion.getInstancia().pool;
        const [result] = await pool.query(
            `UPDATE fotos_referencia SET enlace_foto = ? WHERE id_foto = ?`,
            [enlace_foto, id]
        );
        return result.affectedRows;
    }

    static async obtenerPorId(id) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT * FROM fotos_referencia WHERE id_foto = ?`,
            [id]
        );
        return rows[0] || null;
    }

    static async eliminar(id) {
        const pool = Conexion.getInstancia().pool;
        const [result] = await pool.query(
            `DELETE FROM fotos_referencia WHERE id_foto = ?`,
            [id]
        );
        return result.affectedRows;
    }
}

export default FotoReferenciaModel;