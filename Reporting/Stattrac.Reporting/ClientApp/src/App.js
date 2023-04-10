import React, { Component } from 'react';
import { Route } from 'react-router';
import { Layout } from './components/Layout';
import { Home } from './components/Home';
import { AuditTrail } from './components/AuditTrail';
import { Admin } from './components/Admin';
import { Login } from './components/Login';

import './custom.css'

export default class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            loggedIn: false
        };
        window.loggedIn = false;
        this.setLoggedIn = this.setLoggedIn.bind(this);
    }
    static displayName = App.name; 
    setLoggedIn() {
        this.setState({ loggedIn: true });
    }
    setLogOut() {
        this.setState({ loggedIn: false });
        let path = "/login";
        this.props.history.push(path);
    }
    render() {
        if (this.state.loggedIn) {
            return (
                <Layout>
                    <Route exact path="/" component={Home} />
                    <Route exact path="/home" component={Home} />
                    <Route path='/admin' component={Admin} />
                    <Route path='/audittrail' component={AuditTrail} />
                </Layout>
            );
        }
        else {
            return (
                <Route exact path="/" render={(props) => <Login {...props} action={this.setLoggedIn} /> } />
            );
        }
    }
}
