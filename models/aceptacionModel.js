import Conexion from '../instanciadb/Conexion.js';

class AceptacionModel {
    static async aceptarEncargo(fk_encargo, fk_domiciliario) {
        const pool = Conexion.getInstancia().pool;
        const connection = await pool.getConnection();

        try {
            await connection.beginTransaction();

            const [encargos] = await connection.query(
                `SELECT estado_actual FROM encargo WHERE id_encargo = ? FOR UPDATE`,
                [fk_encargo]
            );

            if (encargos.length === 0) {
                throw new Error("El encargo especificado no existe.");
            }

            if (encargos[0].estado_actual !== 'disponible') {
                throw new Error(`El encargo no está disponible (estado actual: ${encargos[0].estado_actual}).`);
            }

            await connection.query(
                `UPDATE encargo SET estado_actual = 'aceptado' WHERE id_encargo = ?`,
                [fk_encargo]
            );

            const [result] = await connection.query(
                `INSERT INTO aceptacion (fk_domiciliario, fk_encargo) VALUES (?, ?)`,
                [fk_domiciliario, fk_encargo]
            );

            await connection.commit();

            return {
                id_aceptacion: result.insertId,
                mensaje: "Encargo aceptado y asignado exitosamente al domiciliario."
            };

        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
}

export default AceptacionModel;