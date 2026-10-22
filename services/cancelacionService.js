import CancelacionModel from '../models/cancelacionModel.js';

class CancelacionService {
    static async procesarCancelacion(data) {
        const { fk_encargo } = data;

        if (!fk_encargo) {
            throw new Error("El campo 'fk_encargo' es obligatorio.");
        }

        return await CancelacionModel.cancelarEncargo(fk_encargo);
    }
}

export default CancelacionService;