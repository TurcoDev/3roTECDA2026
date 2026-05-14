import express from 'express'
const app = express()
import cors from 'cors'
import userRoutes from './routers/user.routes.js';


const port = 3000

const corsOptions = {
  origin: ['http://localhost:5173', 'http://localhost:3000'],
  credentials: true,
  optionsSuccessStatus: 200
};

app.use(cors(corsOptions));

app.use(express.json())
app.use('/users', userRoutes);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})