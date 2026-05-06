let users = [
  { id: 1, name: "Juan" },
  { id: 2, name: "María" },
];

// Simulamos funciones de base de datos

const findAll = () => users;

const findById = (id) => users.find(u => u.id === parseInt(id));

const create = (data) => {
  const newUser = { id: users.length + 1, ...data };
  users.push(newUser);
  return newUser;
}

const update = (id, data) => {
  const user = findById(id);
  if (!user) throw new Error("Usuario no encontrado");
  Object.assign(user, data);
  return user;
}

const deleteElement = (id) => {
  const index = users.findIndex(u => u.id === parseInt(id));
  if (index === -1) throw new Error("Usuario no encontrado");
  users.splice(index, 1);
}

export { findAll, findById, create, update, deleteElement };