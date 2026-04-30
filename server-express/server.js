
import express from 'express'
const app = express()
const PORT = 3000



let users = [
  { id: 1, name: "Pedro" },
  { id: 2, name: "Marta" },
];

app.use(express.json())

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/users', (req, res) => {
  res.send(users)
})

app.post('/user', (req, res) => {
  const newUser = req.body
  newUser.id = users.length + 1
  users.push(newUser)
  res.send({ message: 'Se creó un usuario correctamente!', user: newUser })
})

app.put('/user', (req, res) => {
    const updatedUser = req.body;
    const index = users.findIndex((user) => user.id === updatedUser.id);
    if (index !== -1) {
      users[index] = updatedUser;
      res.send({ message: 'Se actualizó un usuario correctamente!', user: updatedUser });
    } else {
      res.status(404).send({ error: 'Usuario no encontrado' });
    }
})

app.delete('/user/:id', (req, res) => {
  const userId = parseInt(req.params.id);
  if (isNaN(userId)) {
    return res.status(400).send({ error: 'ID de usuario no válido' });
  }
  const index = users.findIndex((user) => user.id === userId);
  if (index !== -1) {
    const deletedUser = users.splice(index, 1);
    res.send({ message: 'Se eliminó un usuario correctamente!', user: deletedUser[0] });
  } else {
    res.status(404).send({ error: 'Usuario no encontrado' });
  }
})

app.listen(PORT, () => {
  console.log(`Example app listening on port http://localhost:${PORT}`)
})