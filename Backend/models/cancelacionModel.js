import Conexion from '../instanciadb/Conexion.js';

class CancelacionModel {
    static async cancelarEncargo(fk_encargo) {
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

            const estadoActual = encargos[0].estado_actual.toLowerCase();

            
            if (estadoActual === 'en camino') {
                throw new Error("No se puede cancelar el encargo porque su estado actual es 'en camino'.");
            }

            if (estadoActual === 'cancelado') {
                throw new Error("El encargo ya se encuentra cancelado.");
            }

        
            await connection.query(
                `UPDATE encargo SET estado_actual = 'cancelado' WHERE id_encargo = ?`,
                [fk_encargo]
            );

        
            await connection.query(
                `INSERT INTO cancelacion_encargo (fk_encargo, fecha_cancelacion) VALUES (?, NOW())`,
                [fk_encargo]
            );

            await connection.commit();

            return {
                mensaje: "El encargo ha sido cancelado exitosamente."
            };

        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
}

export default CancelacionModel;