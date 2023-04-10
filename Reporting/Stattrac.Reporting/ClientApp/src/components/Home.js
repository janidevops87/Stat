import React, { Component } from 'react';

export class Home extends Component {
    static displayName = Home.name;

    render() {
        return (
            <div>
                <div className="row">
                    <div className="col-xs-4">
                        <div className="panel panel-default">
                            <div className="panel-heading">General</div>
                            <div className="panel-body">
                                <div className="lnkReport">Alerts (new)</div>
                                <div className="lnkReport">Error Log Detail (new)</div>
                                <div className="lnkReport">Organization Audit Trail [Internal] (new)</div>
                                <div className="lnkReport">Person Audit Trail [Internal] (new)</div>
                                <div className="lnkReport">z-old Call Staff Statistics</div>
                                <div className="lnkReport">z-old Organization Requestor/Callers</div>
                                <div className="lnkReport">z-old Page Response Times</div>
                                <div className="lnkReport">z-old QA - Import Activity</div>
                                <div className="lnkReport">z-old QA - Message Activity</div>
                            </div>
                        </div>
                    </div>
                    <div className="col-xs-4">
                        <div className="panel panel-default">
                            <div className="panel-heading">Messages</div>
                            <div className="panel-body">
                                <div className="lnkReport">Message Activity (new)</div>
                                <div className="lnkReport">Message Audit Trail (new)</div>
                                <div className="lnkReport">Message Detail (new)</div>

                            </div>
                        </div>
                    </div>
                    <div className="col-xs-4">
                        <div className="panel panel-default">
                            <div className="panel-heading">Imports</div>
                            <div className="panel-body">
                                <div className="lnkReport">Import Offer Activity (new)</div>
                                <div className="lnkReport">Import Offer Audit Trail (new)</div>
                                <div className="lnkReport">Import Offer Detail (new)</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}
