import express from 'express'
const app = express()
import userRoutes from './routers/user.routes.js';
const port = 3000

app.use(express.json())
app.use('/users', userRoutes);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})