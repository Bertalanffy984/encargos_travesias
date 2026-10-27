import express from 'express';
import AceptacionService from '../services/aceptacionService.js';

const aceptarEncargoRouter = express.Router();

aceptarEncargoRouter.post('/aceptar', async (req, res) => {
    try {
        const resultado = await AceptacionService.procesarAceptacion(req.body);
        res.status(201).json({
            success: true,
            data: resultado
        });
    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message
        });
    }
});

export default aceptarEncargoRouter;