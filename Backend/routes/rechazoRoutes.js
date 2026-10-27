import express from 'express';
import RechazoService from '../services/rechazoService.js';

const rechazoEncargoRouter = express.Router();

rechazoEncargoRouter.post('/rechazar', async (req, res) => {
    try {
        const resultado = await RechazoService.procesarRechazo(req.body);
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

export default rechazoEncargoRouter;