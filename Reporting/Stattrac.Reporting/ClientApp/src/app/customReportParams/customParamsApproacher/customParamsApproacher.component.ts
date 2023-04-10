import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsApproacherModel } from './CustomParamsApproacherModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterDropDownDefault } from '../../parameterdropdowndefault.service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';


@Component({
  templateUrl: './customParamsApproacher.component.html'
})
export class CustomParamsApproacherComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, private pm: ParameterDropDownDefault,private pc: ParameterPopupComponent) {
    
  }

  ngOnInit() {
    this.reportGroupId = this.pm.getReportGroupdID();
    this.approacherOrganizationList = this.pm.getOrganizationData();
    this.subscription = this.pc.getreportGroupChangeEmitter().subscribe(item => this.selectedReportGroup(item));
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

  

  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsApproacherModel();
  approacherOrganizationList = [];
  approacherOrgTypeValue: string;
  approacherList = [];
  subscription: any;
  reportGroupId: number;

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  ApproacherOrgScrollToEnd() {
    this.appHttpService.get("ReportOrganizationDropdown", "?reportGroupId=" + this.reportGroupId + "&lastRowId=" + this.approacherOrganizationList.length).then(res => {
      this.approacherOrganizationList = this.approacherOrganizationList.concat(res);
    });
  }

  searchApproacherOrg(event: any) {
    this.approacherOrgTypeValue = event.term;
    switch (this.approacherOrgTypeValue.length) {
      case 0: {
        this.approacherOrganizationList = [];
        this.approacherOrgTypeValue = '';
        this.getOrganizationFromDatabase(this.reportGroupId, this.approacherOrganizationList.length, this.approacherOrgTypeValue);
        break;
      }
      case 1:
      case 2: {
        this.approacherOrganizationList = [];
        this.approacherOrgTypeValue = '';
        break;
      }
      default: {
        this.approacherOrganizationList = [];
        this.getOrganizationFromDatabase(this.reportGroupId, 0, this.approacherOrgTypeValue);
      }
    }
  }

  selectedReportGroup(item: number) {
    if (this.reportGroupId !== item) {
      this.reportGroupId = item;
      this.approacherOrganizationList = [];
      this.approacherOrgTypeValue = '';
      this.model.ApproacherOrganizationId = null;
      this.model.ApproacherId = null;
      this.getOrganizationFromDatabase(this.reportGroupId, this.approacherOrganizationList.length, this.approacherOrgTypeValue);
      this.addtoParameterList();
    }
  }

  validateApproacherOrgDropdown() {
    if (this.approacherOrganizationList.length < 1) {
      if (this.reportGroupId === this.pm.getReportGroupdID()) {
        this.approacherOrganizationList = this.pm.getOrganizationData();
      }
      else {
        this.getOrganizationFromDatabase(this.reportGroupId, 0, this.approacherOrgTypeValue);
      }
    }
  }

  getApproacherPersonData(): void {
    this.approacherList = [];
    this.model.ApproacherId = null;
    if (this.model.ApproacherOrganizationId !== undefined && this.model.ApproacherOrganizationId !== null) {
      this.appHttpService.get("ApproacherPersonDropDown", "?organizationId=" + this.model.ApproacherOrganizationId).then(res => {
        this.approacherList = res;
      });
    }
  }

  clearApproacherOrg() {
    this.approacherOrganizationList = [];
    this.approacherOrgTypeValue = '';
    this.model.ApproacherOrganizationId = null;
    this.model.ApproacherId = null;
    this.getOrganizationFromDatabase(this.reportGroupId, this.approacherOrganizationList.length, this.approacherOrgTypeValue);
    this.addtoParameterList();
  }

  approacherOrganizationChanged() {
    this.getApproacherPersonData();
    this.addtoParameterList();
  }

  private getOrganizationFromDatabase(reportGroupId, lastRowId, searchTerm) {
    this.appHttpService.get("ReportOrganizationDropdown", "?reportGroupId=" + reportGroupId + "&lastRowId=" + lastRowId + "&searchterm=" + searchTerm).then(res => {
      this.approacherOrganizationList = this.approacherOrganizationList.concat(res);
    });
  }

}
