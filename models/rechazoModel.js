import Conexion from '../instanciadb/Conexion.js';

class RechazoModel {
    static async rechazarAceptacion(fk_encargo, fk_domiciliario) {
        const pool = Conexion.getInstancia().pool;
        const connection = await pool.getConnection();

        try {
            await connection.beginTransaction();
            const [aceptaciones] = await connection.query(
                `SELECT id_aceptacion FROM aceptacion 
                 WHERE fk_encargo = ? AND fk_domiciliario = ? 
                 ORDER BY fecha_aceptacion DESC LIMIT 1 FOR UPDATE`,
                [fk_encargo, fk_domiciliario]
            );

            if (aceptaciones.length === 0) {
                throw new Error("No se encontró una aceptación activa para este encargo y domiciliario.");
            }

            const id_aceptacion = aceptaciones[0].id_aceptacion;
            const [encargos] = await connection.query(
                `SELECT estado_actual FROM encargo WHERE id_encargo = ? FOR UPDATE`,
                [fk_encargo]
            );

            if (encargos.length === 0 || encargos[0].estado_actual !== 'aceptado') {
                throw new Error(`El encargo no se puede rechazar porque su estado actual es '${encargos[0]?.estado_actual || 'desconocido'}'.`);
            }

            await connection.query(
                `INSERT INTO rechazo_aceptacion (fk_aceptacion, fecha_rechazo) VALUES (?, NOW())`,
                [id_aceptacion]
            );

            await connection.query(
                `UPDATE encargo SET estado_actual = 'disponible' WHERE id_encargo = ?`,
                [fk_encargo]
            );

            await connection.commit();

            return {
                mensaje: "Encargo rechazado exitosamente. El encargo ha vuelto a estar disponible."
            };

        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
}

export default RechazoModel;