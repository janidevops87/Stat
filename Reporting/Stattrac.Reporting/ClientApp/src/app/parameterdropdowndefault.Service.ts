import { Injectable, OnInit } from '@angular/core';
import { AppHttpService } from './apphttp.Service';
import { Globals } from './globals.Service';
import { Session } from 'protractor';

@Injectable()
export class ParameterDropDownDefault {
  
  constructor(private appHttpService: AppHttpService, private globals: Globals) {

  }

  public setupReportGroupID(rptGroupId) {
    sessionStorage.setItem('reportGroupId', rptGroupId);
    this.setupReportGroupData();
    this.setupReportCoordinatorData();
    this.setupReportSourceCodeData();
    this.setupReportOrganizationData();
  }

  public getReportGroupdID() {
    const id: number = + sessionStorage.getItem('reportGroupId');
    return id;
  }

  public getreportGroupData() {
    return JSON.parse(sessionStorage.getItem('reportGroupDefaultList'));
  }

  public getOrganizationData() {
    return JSON.parse(sessionStorage.getItem('organizationDefaultList'));
  }

  public getSourceCodeData() {
    return JSON.parse(sessionStorage.getItem('sourceCodeDefaultList'));
  }

  public getCoordinatorData() {
    return JSON.parse(sessionStorage.getItem('coordinatorDefaultList'));
  }

  private setupReportGroupData() {

    this.appHttpService.get("ReportGroupDropdown", "?userOrganizationId=" + Globals.userOrganizationId).then(res => {
      sessionStorage.setItem('reportGroupDefaultList', JSON.stringify(res));
    });
  }

  private setupReportOrganizationData(): void {

    this.appHttpService.get("ReportOrganizationDropdown", "?reportGroupId=" + sessionStorage.getItem('reportGroupId')).then(res => {
        sessionStorage.setItem('organizationDefaultList', JSON.stringify(res));
      });
  }

  private setupReportSourceCodeData(): void {
    this.appHttpService.get("ReportSourceCodeDropdown", "?webReportGroupId=" + sessionStorage.getItem('reportGroupId') ).then(res => {
      sessionStorage.setItem('sourceCodeDefaultList', JSON.stringify(res));
    });
  }

  private setupReportCoordinatorData(): void {
    this.appHttpService.get("ReportCoordinatorDropdown", "?userOrganizationId" + Globals.userOrganizationId + "&webreportGroupId=" + sessionStorage.getItem('reportGroupId')).then(res => {
      sessionStorage.setItem('coordinatorDefaultList', JSON.stringify(res));
    });
  }

  
}
