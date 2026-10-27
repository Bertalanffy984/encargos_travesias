import RechazoModel from '../models/rechazoModel.js';

class RechazoService {
    static async procesarRechazo(data) {
        const { fk_encargo, fk_domiciliario } = data;

        if (!fk_encargo || !fk_domiciliario) {
            throw new Error("Los campos 'fk_encargo' y 'fk_domiciliario' son obligatorios.");
        }

        return await RechazoModel.rechazarAceptacion(fk_encargo, fk_domiciliario);
    }
}

export default RechazoService;