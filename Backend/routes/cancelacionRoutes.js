import express from 'express';
import CancelacionService from '../services/cancelacionService.js';

const cancelacionRouter = express.Router();

cancelacionRouter.post('/cancelar', async (req, res) => {
    try {
        const resultado = await CancelacionService.procesarCancelacion(req.body);
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

export default cancelacionRouter;