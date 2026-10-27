import AceptacionModel from '../models/aceptacionModel.js';

class AceptacionService {
    static async procesarAceptacion(data) {
        const { fk_encargo, fk_domiciliario } = data;

        if (!fk_encargo || !fk_domiciliario) {
            throw new Error("Los campos 'fk_encargo' y 'fk_domiciliario' son obligatorios.");
        }

        return await AceptacionModel.aceptarEncargo(fk_encargo, fk_domiciliario);
    }
}

export default AceptacionService;