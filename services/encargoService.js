import EncargoModel from '../models/encargoModel.js';

class EncargoService {
    static async registrarEncargo(datosEncargo) {

        if (!datosEncargo.fk_solicitante || !datosEncargo.descripción || !datosEncargo.remuneración) {
            throw new Error("Los campos 'fk_solicitante', 'descripción' y 'remuneración' son obligatorios.");
        }

        const idEncargo = await EncargoModel.crear(datosEncargo);
        return { 
            id_encargo: idEncargo, 
            mensaje: "Encargo registrado exitosamente y disponible para los domiciliarios." 
        };
    }

    static async listarEncargosDisponibles() {
        return await EncargoModel.obtenerDisponibles();
    }
}

export default EncargoService;