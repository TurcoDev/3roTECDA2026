import CardUser from './components/CardUser'
import './App.css'
import { results } from './data/data'
import Button from './components/Button'

function App() {

  return (
    <>
      <Button />
      {results.map((user, index) => (
        <CardUser
          key={index}
          name={`${user.name.first} ${user.name.last}`}
          email={user.email}
          image={user.picture.thumbnail}
        />
      ))}
      {/* <CardUser name='Juan Perez' email='jj@jj' image='https://randomuser.me/api/portraits/men/75.jpg'/> */}
      {/* <CardUser image='https://randomuser.me/api/portraits/men/15.jpg' name='Roberto Carlos' email='jj@jj.com'/> */}
    </>
  )
}

export default App
