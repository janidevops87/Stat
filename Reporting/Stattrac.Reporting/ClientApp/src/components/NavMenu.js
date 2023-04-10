import React, { Component } from 'react';
import { Collapse, Container, Navbar, NavbarBrand, NavbarToggler, NavItem, NavLink } from 'reactstrap';
import { Link } from 'react-router-dom';
import './NavMenu.css';
import { createBrowserHistory } from "history"

const history = createBrowserHistory();

export class NavMenu extends Component {
    static displayName = NavMenu.name;

    constructor(props) {
        super(props);

        this.toggleNavbar = this.toggleNavbar.bind(this);
        this.state = {
            collapsed: true
        };
        this.logout = this.logout.bind(this);

    }

    toggleNavbar() {
        this.setState({
            collapsed: !this.state.collapsed
        });
    }

    logout(event) {
        event.preventDefault();
        var dis = this;
        fetch('/logout', {
            method: 'POST'
        }).then(function (response) {
            if (response.status !== 200) {
                throw new Error(response.status);
            }
            else {
                dis.setState({ authenticated: false });
                let path = "/login";
                window.location.href = '/';
            }
        });
    }

    render() {
        return (
            <header history={history}>
                <Navbar className="navbar-expand-sm navbar-toggleable-sm navbar-dark bg-dark border-bottom box-shadow mb-4" light>
                    <Container>
                        <NavbarBrand tag={Link} to="/">Stattrac Reporting</NavbarBrand>
                        <NavbarToggler onClick={this.toggleNavbar} className="mr-2" />
                        <Collapse className="d-sm-inline-flex flex-sm-row-reverse" isOpen={!this.state.collapsed} navbar>
                            <ul className="navbar-nav flex-grow">
                                <NavItem>
                                    <NavLink tag={Link} className="text-light" to="/">Home</NavLink>
                                </NavItem>
                                <NavItem>
                                    <NavLink tag={Link} className="text-light" to="/admin">Admin</NavLink>
                                </NavItem>
                                <NavItem>
                                    <NavLink tag={Link} className="text-light" to="/audittrail">Audit Trail</NavLink>
                                </NavItem>
                                <NavItem>
                                    <NavLink tag={Link} className="text-light" to="/" onClick={this.logout}>Logout</NavLink>
                                </NavItem>
                            </ul>
                        </Collapse>
                    </Container>
                </Navbar>
            </header>
        );
    }
}
