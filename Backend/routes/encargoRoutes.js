import express from 'express';
import EncargoService from '../services/encargoService.js';
import EncargoModel from '../models/encargoModel.js'

const encargoRouter = express.Router();

encargoRouter.get('/disponibles', async (req, res) => {
    try {
        const encargos = await EncargoService.listarEncargosDisponibles();
        res.status(200).json({
            success: true,
            data: encargos
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message
        });
    }
});

encargoRouter.post('/crear', async (req, res) => {
    try {
        const nuevoEncargo = await EncargoService.registrarEncargo(req.body);
        res.status(201).json({
            success: true,
            data: nuevoEncargo
        });
    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message
        });
    }
});


encargoRouter.get('/solicitante/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const encargos = await EncargoModel.obtenerPorSolicitante(id);
        res.status(200).json({ success: true, data: encargos });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

encargoRouter.get('/domiciliario/:id', async (req, res) => {
    try {
        const encargos = await EncargoModel.obtenerPorDomiciliario(req.params.id);
        res.status(200).json({ success: true, data: encargos });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

encargoRouter.get('/actividad', async (_req, res) => {
    try {
        const actividad = await EncargoModel.obtenerActividad();
        res.status(200).json({ success: true, data: actividad });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

encargoRouter.get('/domiciliario/:id/entregados', async (req, res) => {
    try {
        const { id } = req.params;
        const encargos = await EncargoModel.obtenerEntregadosComoDomiciliario(id);
        res.status(200).json({ success: true, data: encargos });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

export default encargoRouter;