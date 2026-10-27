import express from 'express';
import UbicacionService from '../services/ubicacionService.js';

const ubicacionRouter = express.Router();
//este endpoint puede no usarse
ubicacionRouter.get('/listarTodas', async (req, res) => {
    try {
        const ubicaciones = await UbicacionService.listarUbicaciones();
        res.status(200).json({ success: true, data: ubicaciones });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});


ubicacionRouter.get('/buscar/:id', async (req, res) => {
    try {
        const ubicacion = await UbicacionService.obtenerUbicacionPorId(req.params.id);
        res.status(200).json({ success: true, data: ubicacion });
    } catch (error) {
        res.status(404).json({ success: false, message: error.message });
    }
});

// POST /api/ubicaciones - Crear nueva ubicación
ubicacionRouter.post('/crear', async (req, res) => {
    try {
        const nuevaUbicacion = await UbicacionService.registrarUbicacion(req.body);
        res.status(201).json({ success: true, data: nuevaUbicacion });
    } catch (error) {
        res.status(400).json({ success: false, message: error.message });
    }
});

// PUT /api/ubicaciones/:id - Actualizar ubicación
ubicacionRouter.put('/actualizar/:id', async (req, res) => {
    try {
        const actualizada = await UbicacionService.actualizarUbicacion(req.params.id, req.body);
        res.status(200).json({ success: true, data: actualizada });
    } catch (error) {
        res.status(400).json({ success: false, message: error.message });
    }
});

// DELETE /api/ubicaciones/:id - Eliminar ubicación
ubicacionRouter.delete('/eliminar/:id', async (req, res) => {
    try {
        const resultado = await UbicacionService.eliminarUbicacion(req.params.id);
        res.status(200).json({ success: true, data: resultado });
    } catch (error) {
        res.status(400).json({ success: false, message: error.message });
    }
});

export default ubicacionRouter;