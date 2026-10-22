import Conexion from '../instanciadb/Conexion.js';

class EstadoModel {
    static async cambiarEstado(fk_encargo, nuevoEstado) {
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
            const estadoLower = nuevoEstado.toLowerCase();

            const [estadosValidos] = await connection.query(
                `SELECT * FROM estado_encargo WHERE LOWER(nombre_estado) = ?`,
                [estadoLower]
            );

            if (estadosValidos.length === 0) {
                throw new Error(`El estado '${nuevoEstado}' no es un estado válido en el sistema.`);
            }
            if (estadoLower === 'entregado') {
                // No se puede entregar si está disponible o cancelado
                if (estadoActual === 'disponible' || estadoActual === 'cancelado') {
                    throw new Error(`No se puede marcar como 'entregado' un encargo que se encuentra en estado '${estadoActual}'. El encargo debe estar aceptado o en camino.`);
                }
                const [domiciliarioCheck] = await connection.query(
                    `SELECT fk_domiciliario FROM aceptacion WHERE fk_encargo = ? LIMIT 1`,
                    [fk_encargo]
                );

                if (domiciliarioCheck.length === 0) {
                    throw new Error("Es imposible marcar el encargo como 'entregado' porque no tiene ningún domiciliario asignado (el encargo nunca fue aceptado).");
                }
            }

            await connection.query(
                `UPDATE encargo SET estado_actual = ? WHERE id_encargo = ?`,
                [estadoLower, fk_encargo]
            );

            // 5. Consultar los datos completos de la persona (domiciliario) que realizó la entrega
            const [domiciliarios] = await connection.query(
                `SELECT h.id_habitante, h.nombre1, h.nombre2, h.apellido1, h.apellido2, h.telefono 
                 FROM aceptacion a
                 JOIN habitante h ON a.fk_domiciliario = h.id_habitante
                 WHERE a.fk_encargo = ?
                 ORDER BY a.fecha_aceptacion DESC
                 LIMIT 1`,
                [fk_encargo]
            );

            await connection.commit();

            return {
                id_encargo: fk_encargo,
                nuevo_estado: estadoLower,
                mensaje: `El estado del encargo ha sido actualizado a '${estadoLower}' exitosamente.`,
                domiciliario: domiciliarios.length > 0 ? domiciliarios[0] : null
            };

        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
}

export default EstadoModel;