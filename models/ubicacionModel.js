import Conexion from '../instanciadb/Conexion.js';

class UbicacionModel {
 
    static async crear(latidud, longitud) {
        const pool = Conexion.getInstancia().pool;
        const [result] = await pool.query(
            `INSERT INTO ubicacion_georeferencial (latidud, longitud, fecha_registro) VALUES (?, ?, NOW())`,
            [latidud, longitud]
        );
        return result.insertId;
    }

    static async obtenerTodas() {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(`SELECT * FROM ubicacion_georeferencial`);
        return rows;
    }

    static async obtenerPorId(id) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(`SELECT * FROM ubicacion_georeferencial WHERE id_ubicacion = ?`, [id]);
        return rows[0] || null;
    }

    static async actualizar(id, latidud, longitud) {
        const pool = Conexion.getInstancia().pool;
        const [result] = await pool.query(
            `UPDATE ubicacion_georeferencial SET latidud = ?, longitud = ? WHERE id_ubicacion = ?`,
            [latidud, longitud, id]
        );
        return result.affectedRows;
    }

    static async eliminar(id) {
        const pool = Conexion.getInstancia().pool;
        const connection = await pool.getConnection();

        try {
            await connection.beginTransaction();

            // 1. Verificar si la ubicación está en uso por algún encargo
            const [encargosEnUso] = await connection.query(
                `SELECT id_encargo FROM encargo WHERE fk_ubicacion_georefencial = ? LIMIT 1`,
                [id]
            );

            // 2. Eliminar la ubicación si no está en uso
            const [result] = await connection.query(
                `DELETE FROM ubicacion_georeferencial WHERE id_ubicacion = ?`,
                [id]
            );

            await connection.commit();
            return result.affectedRows;
        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
}

export default UbicacionModel;