import { Readable } from 'stream';
import FotoReferenciaModel from '../models/fotoReferenciaModel.js';
import Conexion from '../instanciadb/Conexion.js';
import cloudinary from '../config/cloudinary.js';

class FotoReferenciaService {
    static async subirFoto(fk_encargo, file) {
        if (!fk_encargo) {
            throw new Error("El campo 'fk_encargo' es obligatorio.");
        }
        if (!file) {
            throw new Error("No se ha adjuntado ninguna imagen.");
        }

        const pool = Conexion.getInstancia().pool;
        const [encargos] = await pool.query(
            `SELECT id_encargo FROM encargo WHERE id_encargo = ?`,
            [fk_encargo]
        );

        if (encargos.length === 0) {
            throw new Error("El encargo especificado no existe.");
        }

        const subirACloudinary = (fileBuffer) => {
            return new Promise((resolve, reject) => {
                const uploadStream = cloudinary.uploader.upload_stream(
                    { folder: 'encargos_travesias' },
                    (error, result) => {
                        if (result) resolve(result);
                        else reject(error);
                    }
                );
                Readable.from(fileBuffer).pipe(uploadStream);
            });
        };

        const resultadoCloudinary = await subirACloudinary(file.buffer);
        const enlaceFoto = resultadoCloudinary.secure_url;

        const idFoto = await FotoReferenciaModel.crear(fk_encargo, enlaceFoto);

        return {
            id_foto: idFoto,
            fk_encargo: Number(fk_encargo),
            enlace_foto: enlaceFoto,
            mensaje: "Foto de referencia subida y registrada exitosamente."
        };
    }

    static async listarPorEncargo(fk_encargo) {
        return await FotoReferenciaModel.obtenerPorEncargo(fk_encargo);
    }

    static async actualizarFoto(id, file) {
        if (!file) {
            throw new Error("No se ha adjuntado ninguna nueva imagen para actualizar.");
        }

        const fotoExistente = await FotoReferenciaModel.obtenerPorId(id);
        if (!fotoExistente) {
            throw new Error("La foto de referencia especificada no existe.");
        }

        
        const subirACloudinary = (fileBuffer) => {
            return new Promise((resolve, reject) => {
                const uploadStream = cloudinary.uploader.upload_stream(
                    { folder: 'encargos_travesias' },
                    (error, result) => {
                        if (result) resolve(result);
                        else reject(error);
                    }
                );
                Readable.from(fileBuffer).pipe(uploadStream);
            });
        };

        const resultadoCloudinary = await subirACloudinary(file.buffer);
        const nuevoEnlace = resultadoCloudinary.secure_url;

        
        await FotoReferenciaModel.actualizar(id, nuevoEnlace);

        return {
            id_foto: Number(id),
            fk_encargo: fotoExistente.fk_encargo,
            enlace_foto: nuevoEnlace,
            mensaje: "Foto de referencia actualizada exitosamente."
        };
    }

    static async eliminarFoto(id) {
        const foto = await FotoReferenciaModel.obtenerPorId(id);
        if (!foto) {
            throw new Error("La foto de referencia especificada no existe.");
        }

        await FotoReferenciaModel.eliminar(id);
        return {
            mensaje: "Foto de referencia eliminada exitosamente."
        };
    }
}

export default FotoReferenciaService;