import { useEffect, useState } from 'react';
import logo from 'src/logo.svg';
import 'src/App.css';

import { GreeterClient } from 'ts-protos/protos/helloworld/Helloworld_serviceServiceClientPb';
import { HelloRequest } from 'ts-protos/protos/helloworld/helloworld_pb';

function App() {
  const [helloWorld, setHelloWorld] = useState('');

  useEffect(() => {
    const client = new GreeterClient('http://localhost:8080');
    const request = new HelloRequest();
    request.setName('hello');
    
    console.log("Sending request:\n", JSON.stringify(request.toObject()));
    
    client.sayHello(request, {}, (err, response) => {
      if (err) {
        console.error('There was an error!', err);
        return;
      }
      console.log("Received response:\n", JSON.stringify(response.toObject())); 
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
