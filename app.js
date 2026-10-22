 import express from 'express'
 import logger from 'morgan'
 import Conexion from './instanciadb/Conexion.js'
 import encargoRouter from './routes/encargoRoutes.js'
 import aceptarEncargoRouter from './routes/aceptacionRoutes.js'
 import rechazoEncargoRouter from './routes/rechazoRoutes.js'
 import cancelacionRouter from './routes/cancelacionRoutes.js'
 import routerEstado from './routes/estadoRourtes.js'
 import ubicacionRouter from './routes/ubicacionRoutes.js'
 import fotoReferenciaRouter from './routes/fotoReferenciaRoutes.js'
 
const app = express()
 app.use(logger('dev'))
 app.use(express.json())
 app.use(express.urlencoded({ extended: false }))

 // Probar conexión al iniciar
 Conexion.getInstancia().pruebaConexion()

// rutas de los encargos
const encargos='/encargos'
app.use(encargos, encargoRouter)
app.use(encargos, aceptarEncargoRouter)

// rutas relacionadas con los domiciliarios
const rechazoDomiciliario='/domiciliario/encargos'
app.use(rechazoDomiciliario, rechazoEncargoRouter)

//rutas relacionadas con los creadores del domicilio
const cancelaCreadorPedido='/creador'
app.use(cancelaCreadorPedido, cancelacionRouter)

//rutas relacionadas con cambiar el estado del encargo
app.use(encargos, routerEstado)

//rutas relacionadas con las ubicaciones
const ubicacion='/ubicacion'
app.use(ubicacion, ubicacionRouter)

//rutas relacionadas con las fotografias
const fotos='/fotos'
app.use(fotos, fotoReferenciaRouter)

export default app
