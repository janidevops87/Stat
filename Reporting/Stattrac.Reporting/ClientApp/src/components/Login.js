import React, { Component } from 'react';
import { Redirect } from 'react-router';

import { Col, Form,
    FormGroup, Label, Input,
    Button,
} from 'reactstrap';

export class Login extends Component {
    static displayName = Login.name;
    constructor(props) {
        super(props);

        this.state = {
            username: "",
            password: "",
            authenticated : false
        };
        this.login = this.login.bind(this);
    }

    validateForm() {
        return this.state.username.length > 0 && this.state.password.length > 0;
    }
    handleChange = event => {
        this.setState({
            [event.target.id]: event.target.value
        });
    }

    login(event) {
        event.preventDefault();
        const data = new FormData(event.target);
        var dis = this;
        fetch('/login', {
            method: 'POST',
            body: data
        }).then(function (response) {
            if (response.status !== 200) {
                throw new Error(response.status);
            }
            else {
                dis.setState({ authenticated: true });
                dis.props.action();
            }
        });
    }

    render() {
        if (this.state.authenticated === true) {
            return (<Redirect to="/home" />);
        }
        return (
            <div>
                <div className="Login">
                    <h2 className="imgLogo"></h2>
                    <h2>Stattrac Reporting</h2>
                    <Form className="form" onSubmit={this.login}>
                        <Col>
                            <FormGroup>
                                <Label>User Name</Label>
                                <Input
                                    type="text"
                                    name="username"
                                    id="username"
                                    onChange={this.handleChange}
                                />
                            </FormGroup>
                        </Col>
                        <Col>
                            <FormGroup>
                                <Label for="password">Password</Label>
                                <Input
                                    type="password"
                                    name="password"
                                    id="password"
                                    onChange={this.handleChange}
                                />
                            </FormGroup>
                        </Col>
                        <Button id="btnLogin" color="primary">Login</Button>
                    </Form>
                </div>
                <div id="divCopyright">Copyright&copy; Statline 1996-2019</div>
            </div>
        );
    }
}