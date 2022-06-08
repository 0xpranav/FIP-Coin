import React from "react";
import Header from "./Header";
import Faucet from "./Faucet";
import Balance from "./Balance";
import Transfer from "./Transfer";
import Footer from "./Footer";


function App(props) {

  return (
    <div id="screen">
      <Header />
      <Faucet userPrincipal = {props.loggedInPrincipal} />
      <Balance />
      <Transfer />
      <Footer/>
    </div>
  );
}

export default App;
