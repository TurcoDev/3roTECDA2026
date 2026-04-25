import { useState } from 'react';
import './Button.css'

// let count = 0

function Button(props) {
  const [count, setCount] = useState(0)

  // function suma() {
  //   console.log(count);
  //   return count + 1;
  // }

  return (
    <>
      <button className="btn" onClick={() => setCount(count + 1)}>
        {props.text}
        {count}
      </button>
      <button className='btn' onClick={() => setCount(0) }>
        Reset
      </button>
      <button className="btn" onClick={() => setCount(count - 1)}>
        {props.text}
        {count}
      </button>
    </>
  )
}

export default Button