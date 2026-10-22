import EstadoModel from '../models/estadoModel.js';

class EstadoService {
    static async actualizarEstadoEncargo(data) {
        const { fk_encargo, estado_actual } = data;

        if (!fk_encargo || !estado_actual) {
            throw new Error("Los campos 'fk_encargo' y 'estado_actual' son obligatorios.");
        }

        return await EstadoModel.cambiarEstado(fk_encargo, estado_actual);
    }
}

export default EstadoService;