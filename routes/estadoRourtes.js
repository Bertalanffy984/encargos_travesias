import express from 'express';
import EstadoService from '../services/estadoService.js';

const routerEstado = express.Router();
routerEstado.put('/actualizarEstado', async (req, res) => {
    try {
        const resultado = await EstadoService.actualizarEstadoEncargo(req.body);
        res.status(200).json({
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

export default routerEstado;