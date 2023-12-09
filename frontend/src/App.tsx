import { useEffect, useState } from 'react';
import logo from './logo.svg';
import './App.css';

import { GreeterClient } from './protos/helloworld/Helloworld_serviceServiceClientPb.ts';
import { HelloRequest } from '../protos/helloworld/helloworld_pb.ts';

function App() {
  const [helloWorld, setHelloWorld] = useState('');

  useEffect(() => {
    axios.get('/api')
      .then(response => {
        setHelloWorld(response.data);
      })
      .catch(error => {
        console.error('There was an error!', error);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>{helloWorld}</p>
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
