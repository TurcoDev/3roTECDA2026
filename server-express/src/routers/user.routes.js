import { Router } from 'express';
const userRoutes = Router();
import userController from '../controllers/user.controller.js';

userRoutes.get('/', userController.getUsers);
userRoutes.get('/:id', userController.getUser);
userRoutes.post('/', userController.createUser);
userRoutes.put('/:id', userController.updateUser);
userRoutes.delete('/:id', userController.deleteUser);


export default userRoutes;