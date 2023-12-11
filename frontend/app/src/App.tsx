import { useEffect, useState } from 'react';
import logo from 'src/logo.svg';
import 'src/App.css';

import { GreeterClient } from 'protos/helloworld/Helloworld_serviceServiceClientPb';
import { HelloRequest } from 'protos/helloworld/helloworld_pb';

function App() {
  const [helloWorld, setHelloWorld] = useState('');

  useEffect(() => {
    const client = new GreeterClient('http://localhost:8000');
    const request = new HelloRequest();
    request.setName('Your Name');
    
    client.sayHello(request, {}, (err, response) => {
      if (err) {
        console.error('There was an error!', err);
        return;
      }
      setHelloWorld(response.getMessage());
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
