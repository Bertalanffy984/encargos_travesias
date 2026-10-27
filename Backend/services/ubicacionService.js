import UbicacionModel from '../models/ubicacionModel.js';

class UbicacionService {
    static async registrarUbicacion(data) {
        const { latidud, longitud } = data;

        if (latidud === undefined || longitud === undefined) {
            throw new Error("Los campos 'latidud' y 'longitud' son obligatorios.");
        }

        if (latidud < -90 || latidud > 90) {
            throw new Error("La latitud debe estar en un rango entre -90 y 90.");
        }
        if (longitud < -180 || longitud > 180) {
            throw new Error("La longitud debe estar en un rango entre -180 y 180.");
        }

        const idUbicacion = await UbicacionModel.crear(latidud, longitud);
        return {
            id_ubicacion: idUbicacion,
            latidud,
            longitud,
            mensaje: "Ubicación georreferencial registrada exitosamente."
        };
    }

    static async listarUbicaciones() {
        return await UbicacionModel.obtenerTodas();
    }

    static async obtenerUbicacionPorId(id) {
        const ubicacion = await UbicacionModel.obtenerPorId(id);
        if (!ubicacion) {
            throw new Error("La ubicación especificada no existe.");
        }
        return ubicacion;
    }

    static async actualizarUbicacion(id, data) {
        const { latidud, longitud } = data;

        if (latidud === undefined || longitud === undefined) {
            throw new Error("Los campos 'latidud' y 'longitud' son obligatorios para actualizar.");
        }

        if (latidud < -90 || latidud > 90) {
            throw new Error("La latitud debe estar en un rango entre -90 y 90.");
        }
        if (longitud < -180 || longitud > 180) {
            throw new Error("La longitud debe estar en un rango entre -180 y 180.");
        }

        await this.obtenerUbicacionPorId(id);

        await UbicacionModel.actualizar(id, latidud, longitud);
        return {
            id_ubicacion: Number(id),
            latidud,
            longitud,
            mensaje: "Ubicación georreferencial actualizada exitosamente."
        };
    }

    static async eliminarUbicacion(id) {
        await this.obtenerUbicacionPorId(id);

        await UbicacionModel.eliminar(id);
        return {
            mensaje: "Ubicación georreferencial eliminada exitosamente."
        };
    }
}

export default UbicacionService;