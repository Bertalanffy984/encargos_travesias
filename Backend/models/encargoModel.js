import Conexion from '../instanciadb/Conexion.js';

class EncargoModel {
    static async crear(data) {
        const pool = Conexion.getInstancia().pool;
        const { fk_solicitante, descripción, descripcion_ubicacion, remuneración } = data;
        const ubicacionId = data.fk_ubicacion_georefencial || data.fk_ubicacion_georrefencial || null;

        const [result] = await pool.query(
            `INSERT INTO encargo (fk_solicitante, fk_ubicacion_georefencial, descripción, descripcion_ubicacion, remuneración, estado_actual) 
             VALUES (?, ?, ?, ?, ?, 'disponible')`,
            [fk_solicitante, ubicacionId, descripción, descripcion_ubicacion || null, remuneración]
        );

        return result.insertId;
    }

    static _selectEncargo() {
        return `
            e.id_encargo,
            e.fk_solicitante,
            e.descripción AS descripcion,
            e.descripcion_ubicacion,
            e.remuneración AS remuneracion,
            e.estado_actual,
            e.fecha_creacion,
            CONCAT_WS(' ', s.nombre1, s.apellido1) AS solicitante,
            (SELECT CONCAT_WS(' ', d.nombre1, d.apellido1)
               FROM aceptacion a
               JOIN habitante d ON d.id_habitante = a.fk_domiciliario
               WHERE a.fk_encargo = e.id_encargo
                 AND NOT EXISTS (
                   SELECT 1 FROM rechazo_aceptacion r WHERE r.fk_aceptacion = a.id_aceptacion
                 )
               ORDER BY a.fecha_aceptacion DESC
               LIMIT 1) AS domiciliario,
            (SELECT COUNT(*) FROM fotos_referencia f WHERE f.fk_encargo = e.id_encargo) AS foto_count,
            (SELECT JSON_ARRAYAGG(f.enlace_foto) FROM fotos_referencia f WHERE f.fk_encargo = e.id_encargo) AS fotos
        `;
    }

    static _filas(rows) {
        return rows.map((row) => {
            let fotos = row.fotos;
            if (Buffer.isBuffer(fotos)) fotos = fotos.toString();
            if (typeof fotos === 'string') {
                try {
                    fotos = JSON.parse(fotos);
                } catch {
                    fotos = [];
                }
            }
            if (!Array.isArray(fotos)) fotos = [];
            return {
                ...row,
                fotos,
                remuneracion: row.remuneracion == null ? 0 : Number(row.remuneracion),
                foto_count: Number(row.foto_count ?? fotos.length),
            };
        });
    }

    static async obtenerDisponibles() {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT ${this._selectEncargo()}
             FROM encargo e
             JOIN habitante s ON s.id_habitante = e.fk_solicitante
             WHERE e.estado_actual = 'disponible'
             ORDER BY e.fecha_creacion DESC`
        );
        return this._filas(rows);
    }


    static async obtenerPorSolicitante(idHabitante) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT ${this._selectEncargo()}
             FROM encargo e
             JOIN habitante s ON s.id_habitante = e.fk_solicitante
             WHERE e.fk_solicitante = ?
             ORDER BY e.fecha_creacion DESC`,
            [idHabitante]
        );
        return this._filas(rows);
    }

    static async obtenerPorDomiciliario(idHabitante) {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT ${this._selectEncargo()}
             FROM encargo e
             JOIN habitante s ON s.id_habitante = e.fk_solicitante
             JOIN aceptacion a ON a.fk_encargo = e.id_encargo
             WHERE a.fk_domiciliario = ?
               AND a.id_aceptacion = (
                 SELECT MAX(a2.id_aceptacion) FROM aceptacion a2
                 WHERE a2.fk_encargo = e.id_encargo AND a2.fk_domiciliario = ?
                   AND NOT EXISTS (
                     SELECT 1 FROM rechazo_aceptacion r WHERE r.fk_aceptacion = a2.id_aceptacion
                   )
               )
             ORDER BY a.fecha_aceptacion DESC`,
            [idHabitante, idHabitante]
        );
        return this._filas(rows);
    }

    static async obtenerActividad() {
        const pool = Conexion.getInstancia().pool;
        const [rows] = await pool.query(
            `SELECT h.id_historial, h.fecha_inicio, est.nombre_estado,
                    e.id_encargo, e.descripción AS descripcion, e.descripcion_ubicacion,
                    CONCAT_WS(' ', s.nombre1, s.apellido1) AS solicitante
             FROM historial_estado_pedido h
             JOIN encargo e ON e.id_encargo = h.fk_encargo
             JOIN habitante s ON s.id_habitante = e.fk_solicitante
             JOIN estado_encargo est ON est.id_estado = h.fk_estado
             ORDER BY h.fecha_inicio DESC
             LIMIT 40`
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