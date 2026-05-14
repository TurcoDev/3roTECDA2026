import { users } from "../data/data.js";
import connection from '../db/dbConnect.js';

connection.connect();
console.log('Connection established successfully');




// Simulamos funciones de base de datos

// const findAll = () => users;

// mysql2 con callbacks
const findAll = async () => {
  return new Promise((resolve, reject) => {
    connection.query('SELECT * FROM user;', (error, results) => {
      if (error) {
        return reject(error);
      }
      resolve(results);
    });
  });
};


// mysql2/promise con async/await
// const findAll = async () => {
//   try {
//     // query() ahora devuelve una promesa que podemos "esperar"
//     const [results, fields] = await connection.query('SELECT * FROM user;');

//     // Retornamos directamente los resultados
//     return results;
//   } catch (error) {
//     console.error('Error en la consulta:', error);
//     throw error;
//   }
// };


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