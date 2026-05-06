

import { findAll, findById, create, update, deleteElement } from '../models/user.model.js';

const getAllUsers = () => {
  return findAll();
};

const getUserById = (id) => {
  const user = findById(id);
  if (!user) throw new Error("Usuario no encontrado");
  return user;
};

const createUser = (data) => {
  return create(data);
};

const updateUser = (id, data) => {
  const user = getUserById(id);
  Object.assign(user, data);
  return update(id, data);
};

const deleteUser = (id) => {
  const index = findAll().findIndex(u => u.id === parseInt(id));
  if (index === -1) throw new Error("Usuario no encontrado");
  deleteElement(id);
};

export default { getAllUsers, getUserById, createUser, updateUser, deleteUser };