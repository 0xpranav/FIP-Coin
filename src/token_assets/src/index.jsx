import ReactDOM from 'react-dom'
import React from 'react'
import App from "./components/App";
import { AuthClient } from "@dfinity/auth-client"; //use to login our user with ic identity
import { Principal } from "@dfinity/principal";

const init = async () => { 

  
  
  const authClient = await AuthClient.create();//create n ew authclient object which will be used to login user.


  if(await authClient.isAuthenticated()){
    handleAuthenticated(authClient);
    console.log("Already logged in");
   
  }else{
    await authClient.login({  //define asyncronously
      identityProvider: "https://identity.ic0.app/#authorize", //identity provider from ICP which will provide frontend for login services.
      onSuccess: async () => {    //onSuccess callback function
        handleAuthenticated(authClient);
        console.log("Successfully Logged In");
        },
        
    });
    
  }

};

async function handleAuthenticated(authClient) {
  const identity = await authClient.getIdentity();
  const userPrincipal = identity._principal.toString();
  console.log(userPrincipal);
  ReactDOM.render(
    <App loggedInPrincipal={userPrincipal} />,
    document.getElementById("root")
  );
};

init();


