import './CardUser.css'

function CardUser(props) {

  return (
    <div className="card">
      <img src={props.image} alt="User Avatar" className="avatar" />
      <h2>{props.name}</h2>
      <p>Email: {props.email}</p>
    </div>
  )
}

export default CardUser