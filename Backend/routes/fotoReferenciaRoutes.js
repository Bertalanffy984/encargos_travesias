import express from 'express';
import upload from '../Middleware/uploadMiddleware.js';
import FotoReferenciaService from '../services/fotoReferenciaService.js';

const fotoReferenciaRouter = express.Router();

fotoReferenciaRouter.post('/subir', upload.single('foto'), async (req, res) => {
    try {
        const resultado = await FotoReferenciaService.subirFoto(req.body.fk_encargo, req.file);
        res.status(201).json({ success: true, data: resultado });
    } catch (error) {
        res.status(400).json({ success: false, message: error.message });
    }
});

fotoReferenciaRouter.get('/listaFotosEncargo/:fk_encargo', async (req, res) => {
    try {
        const fotos = await FotoReferenciaService.listarPorEncargo(req.params.fk_encargo);
        res.status(200).json({ success: true, data: fotos });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

fotoReferenciaRouter.put('/actualizar/:id', upload.single('foto'), async (req, res) => {
    try {
        const resultado = await FotoReferenciaService.actualizarFoto(req.params.id, req.file);
        res.status(200).json({ success: true, data: resultado });
    } catch (error) {
        res.status(400).json({ success: false, message: error.message });
    }
});

fotoReferenciaRouter.delete('/eliminar/:id', async (req, res) => {
    try {
        const resultado = await FotoReferenciaService.eliminarFoto(req.params.id);
        res.status(200).json({ success: true, data: resultado });
    } catch (error) {
        res.status(400).json({ success: false, message: error.message });
    }
});

export default fotoReferenciaRouter;