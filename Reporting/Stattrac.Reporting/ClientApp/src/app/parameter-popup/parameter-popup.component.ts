import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { AppHttpService } from '../apphttp.Service';
import { Globals } from '../globals.Service';
import { GeneralParameterModel } from './GeneralParameterModel';
import { CommonMethods } from '../customReportParams/commonMethods';
import { ParameterDropDownDefault } from '../parameterdropdowndefault.service'

@Component({
  selector: 'app-parameter-popup',
 templateUrl: './parameter-popup.component.html'

})
export class ParameterPopupComponent implements OnInit {
  @Input() customControl: string;
  @Input() reportId: number;
  @Input() reportName: string;
  @Input() reportURL: string;
  @Output() sourceCodeChangeEvent: EventEmitter<string> = new EventEmitter(true);
  @Output() reportGroupChangeEvent: EventEmitter<number> = new EventEmitter(true);
  selectedReportParameterData;
  reportDateTypeList = [];
  reportGroupList = [];
  organizationList = [];
  organizationTypeValue: string = '';
  sourceCodeList = [];
  coordinatorList = [];
  genderList = [];
  sortingOptionsList = [];
  sourceCodeTypeId;
  model = new GeneralParameterModel();
  method = new CommonMethods();

  constructor(private appHttpService: AppHttpService, public globals: Globals, private pm : ParameterDropDownDefault) {
    this.genderList = [{ value: 'F', label: 'Female' }, { value: 'M', label: 'Male' }];
    
  }

  ngOnInit() {
    this.loadComponent();
  }

  
  loadComponent() {
    this.model.UserOrgID = Globals.userOrganizationId;
    this.model.UserDisplayName = Globals.userFullName;
    //statline users sees the time zone, everyone else, it defaults to referral facility and is hidden
    if (Globals.userOrganizationId.toString() === "194") {
      this.model.DisplayMT = "true";
    }
    else {
      this.model.DisplayMT = "false";
    }
    this.model.HideIdentifyingInfo = false;

    this.appHttpService.get("reportdefaults", "?reportId=" + this.reportId + '&userOrganizationId=' + Globals.userOrganizationId + '&webPersonId=' + Globals.webPersonId).then(res => {
      this.model.ReportGroupID = res[0].reportGroupId;
      //get defaults
      if (this.model.ReportGroupID === this.pm.getReportGroupdID()) {
        this.reportGroupList = this.pm.getreportGroupData();
      }
      else {
        this.pm.setupReportGroupID(this.model.ReportGroupID);
        this.getReportGroupData();
      }
      this.model.StartDateTime = res[0].startDate;
      this.model.StartTime = res[0].startTime;
      //(document.getElementById('StartTime') as HTMLInputElement).value = res[0].startTime;
      this.model.EndDateTime = res[0].endDate;
      this.model.EndTime = res[0].endTime;
      //(document.getElementById('EndTime') as HTMLInputElement).value = res[0].endTime;
      this.model.ReportDateTypeId = res[0].reportDateTypeId;
      this.model.BlockEventLog = res[0].blockEventLog;
      
      this.sourceCodeTypeId = res[0].sourceCodeTypeId;
      if (res[0].isDateOnly) {
        document.getElementById('StartTime').style.display = "none";
        document.getElementById('EndTime').style.display = "none";
      }
      this.displayControlsOnScreen();
      
    }).then().catch(error => {
      console.log(error);
    });
    
  }

  displayControlsOnScreen(): void {
    this.appHttpService.get("reportParametersControl", "?reportID=" + this.reportId).then(res => {
      this.selectedReportParameterData = res;

      for (let i = 0; i < this.selectedReportParameterData.length; i++) {
        //if timezone control and user not statline, do not show control
        if (this.selectedReportParameterData[i].reportControlName === "rbtTimeZone" && Globals.userOrganizationId.toString() !== "194") {
          continue;
        }
        const element = document.getElementById(this.selectedReportParameterData[i].reportControlName);
        if (element !== null) {
          element.style.display = "block";
        }
        const section = document.getElementById(this.selectedReportParameterData[i].reportParamSectionName);
        if (section !== null) {
          section.style.display = "block";
        }
      }

      if (this.model.ReportGroupID !== undefined && this.model.ReportGroupID !== null) {
        if (document.getElementById('ddlOrganization').style.display === "block") {
          if (this.model.ReportGroupID === this.pm.getReportGroupdID()) {
            this.organizationList = this.pm.getOrganizationData();
            //just in case something happens to the storage
            if (this.organizationList.length == 0) {
              this.getReportOrganizationData(this.model.ReportGroupID);
            }
          }
          else {
            this.getReportOrganizationData(this.model.ReportGroupID);
          }
        }
        if (document.getElementById('ddlOrganizationCoordinator').style.display === "block") {
          if (this.model.ReportGroupID === this.pm.getReportGroupdID()) {
            this.coordinatorList = this.pm.getCoordinatorData();
            //just in case something happens to the storage
            if (this.coordinatorList.length == 0) {
              this.getReportCoordinatorData(this.model.ReportGroupID);
            }
          } else {
            this.getReportCoordinatorData(this.model.ReportGroupID);
          }
        }
        if (document.getElementById('ddlSourceCode').style.display === "block") {
          if ((this.sourceCodeTypeId === undefined || this.sourceCodeTypeId == null) && this.model.ReportGroupID === this.pm.getReportGroupdID()) {
            this.sourceCodeList = this.pm.getSourceCodeData();
          }
          else {
            this.getReportSourceCodeData(this.model.ReportGroupID);
          }
        }

      }
      this.getSortTypeData(this.reportId);
      this.getDateTypeData(this.reportId);
      this.reportGroupChangeEvent.emit(this.model.ReportGroupID);
    }).then().catch(error => {
      console.log(error);
    });
  }

  getDateTypeData(id): void {
    this.reportDateTypeList = [];
    if (document.getElementById('ddlReportDateType').style.display === "block") {
      this.appHttpService.get("DateTypeDropdown", "?reportID=" + id).then(res => {
        this.reportDateTypeList = res;
      });
    }
  }

  getReportGroupData(): void{
    this.reportGroupList = [];

    this.appHttpService.get("ReportGroupDropdown", "?userOrganizationId=" + Globals.userOrganizationId).then(res => {
      this.reportGroupList = res;
    });
  }

  getReportOrganizationData(reportGroupId): void {
    this.organizationList = [];
    this.organizationTypeValue = '';
    if (document.getElementById('ddlOrganization').style.display === "block") {
      this.getOrganizationFromDatabase(reportGroupId, 0, '');
      //this.appHttpService.get("ReportOrganizationDropdown", "?reportGroupId=" + reportGroupId).then(res => {
      //  this.organizationList = res;
      //});
    }
  }

  private getOrganizationFromDatabase(reportGroupId, lastRowId, searchTerm) {
    if (document.getElementById('ddlOrganization').style.display === "block") {
      this.appHttpService.get("ReportOrganizationDropdown", "?reportGroupId=" + reportGroupId + "&lastRowId=" + lastRowId + "&searchterm=" + searchTerm).then(res => {
        this.organizationList = this.organizationList.concat(res);
      });
    }
  }

  searchOrg(event: any) {
    this.organizationTypeValue = event.term;
    switch (this.organizationTypeValue.length) {
      case 0: {
        this.organizationList = this.pm.getOrganizationData();
        break;
      }
      case 1:
      case 2: {
        this.organizationList = [];
        this.organizationTypeValue = '';
        break;
      }
      default: {
        this.organizationList = [];
        this.getOrganizationFromDatabase(this.model.ReportGroupID, 0, this.organizationTypeValue);
      }
    }
  }

  searchReportGroup(event: any) {
    switch (event.term.length) {
      case 0: {
        this.reportGroupList = this.pm.getreportGroupData();
        break;
      }
      case 1:
      case 2: {
        this.reportGroupList = [];
        break;
      }
      default: {
        this.reportGroupList = this.pm.getreportGroupData().filter(function (e) {
          return e.label.toLowerCase().startsWith(event.term.toLowerCase());
        });
        
      }
    }

  }

  reportGroupOnFocus(event: any) {
      this.reportGroupList = this.pm.getreportGroupData();
  }

  organizationScrollToEnd() {
    if (document.getElementById('ddlOrganization').style.display === "block") {
      
      this.getOrganizationFromDatabase(this.model.ReportGroupID, this.organizationList.length, this.organizationTypeValue);
    }
  }

  organizationClear() {
    this.organizationTypeValue = '';
    this.organizationList = [];
    this.validateOrganizationDropdown();
  }

  validateOrganizationDropdown() {
    if (this.organizationList.length < 1) {
      if (this.model.ReportGroupID === this.pm.getReportGroupdID()) {
        this.organizationList = this.pm.getOrganizationData();
      }
      else {
        this.getOrganizationFromDatabase(this.model.ReportGroupID, 0, this.organizationTypeValue);
      }
    }
  }



  getReportSourceCodeData(reportGroupId): void {
    this.sourceCodeList = [];
    //TODO:  sourcecode type needs to passed in by reports
    if (document.getElementById('ddlSourceCode').style.display === "block") {
      let params = "";
      if (this.sourceCodeTypeId !== undefined && this.sourceCodeTypeId !== null) {
        params = "&sourceCodeTypeId=" + this.sourceCodeTypeId;
      }
      this.appHttpService.get("ReportSourceCodeDropdown", "?webReportGroupId=" + reportGroupId +  params).then(res => {
        this.sourceCodeList = res;
      });
    }
  }

  getReportCoordinatorData(reportGroupId): void {
    this.coordinatorList = [];
    if (document.getElementById('ddlOrganizationCoordinator').style.display === "block") {
      this.appHttpService.get("ReportCoordinatorDropdown", "?userOrganizationId" + Globals.userOrganizationId + "&webreportGroupId=" + reportGroupId).then(res => {
        this.coordinatorList = res;
      });
    }
  }

  getSortTypeData(id): void {
    this.sortingOptionsList = [];
    if (document.getElementById('SortOptions').style.display === "block") {
      this.appHttpService.get("ReportSortTypeDropdown", "?reportID=" + id).then(res => {
        this.sortingOptionsList = res;
      });
    }
  }

  public reportGroupChange(value: any): void{
    const id = value.value;
    this.model.OrganizationID = null;
    this.model.SourceCodeName = null;
    this.model.CoordinatorID = null;
    if (id !== undefined && id !== null) {
      this.getReportOrganizationData(id);
      this.getReportCoordinatorData(id);
      this.getReportSourceCodeData(id);
    }
    this.reportGroupChangeEvent.emit(id);
  }

  public sourceCodeChange(value: any): void {
    let id = null;
    if (value !== undefined) {
      id = value.value;
    }
    this.sourceCodeChangeEvent.emit(id);
  }

  public getsourceCodeChangeEmitter() {
    return this.sourceCodeChangeEvent;
  }

  public getreportGroupChangeEmitter() {
    return this.reportGroupChangeEvent;
  }

  public endDateTimeChange(): void {
    const el = document.getElementById('EndDateTime') as HTMLInputElement;
    const time = document.getElementById('EndTime') as HTMLInputElement;
    if (el.value === "")
      this.model.EndDateTime = null;
    else {
      
      let timeString = "00:00";
      if (time.value.length > 0) {
        timeString = time.value;
      }
      this.model.EndDateTime = el.value + " " + timeString;
    }
  }

  public startDateTimeChange(): void {
    const el = document.getElementById('StartDateTime') as HTMLInputElement;
    const time = document.getElementById('StartTime') as HTMLInputElement;
    if (el.value === "")
      this.model.StartDateTime = null;
    else {
      
      let timeString = "00:00";
      if (time.value.length > 0) {
        timeString = time.value;
      }
      this.model.StartDateTime = el.value + " " + timeString;
    }
  }

  public CreateParameterList(): any {
    //double check dates
    this.endDateTimeChange();
    this.startDateTimeChange();
    let params = this.method.addtoParameterList(this.model);
    //find custom parameters, if exists
    const control = document.getElementById("customParameterList");
    if (control !== null) {
      const items = control.getAttribute('value');
      if (items !== undefined && items !== null && items.length > 0) {
        params += "|" + items;
      }
    }
    return params;
  }

  startTimeKeyDown($event): void {
    let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Backspace", "ArrowRight","ArrowLeft","Delete"];
    if (nums.find(x => x == $event.key) == undefined)
      return;
    let val = (document.getElementById('StartTime') as HTMLInputElement).value;
    if ($event.key == "Backspace" || $event.key == "ArrowRight" || $event.key == "ArrowLeft" || $event.key == "Delete")
      return;
    let key = $event.key;
    let valid = false;
    switch (val.length) {
      case 0:
      case 5:
        if (key == "0" || key == "1" || key == "2")
          valid = true;
        break;
      case 1:
        if (val.charAt(0) == "2" && (key == "0" || key == "1" || key == "2" || key == "3"))
          valid = true;
        if (val.charAt(0) == "0" || val.charAt(0) == "1")
          valid = true;
        break;
      case 2:
      case 3:
        if (key == "0" || key == "1" || key == "2" || key == "3" || key == "4" || key == "5")
          valid = true;
        break;
      default:
          valid = true;
        break;
    }
    if (!valid) {
      $event.preventDefault();
    }
  }

  endTimeKeyDown($event): void {
    let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Backspace", "ArrowRight", "ArrowLeft", "Delete"];
    if (nums.find(x => x == $event.key) == undefined)
      return;
    let val = (document.getElementById('EndTime') as HTMLInputElement).value;
    if ($event.key == "Backspace" || $event.key == "ArrowRight" || $event.key == "ArrowLeft" || $event.key == "Delete")
      return;
    let key = $event.key;
    let valid = false;
    switch (val.length) {
      case 0:
      case 5:
        if (key == "0" || key == "1" || key == "2")
          valid = true;
        break;
      case 1:
        if (val.charAt(0) == "2" && (key == "0" || key == "1" || key == "2" || key == "3"))
          valid = true;
        if (val.charAt(0) == "0" || val.charAt(0) == "1")
          valid = true;
        break;
      case 2:
      case 3:
        if (key == "0" || key == "1" || key == "2" || key == "3" || key == "4" || key == "5")
          valid = true;
        break;
      default:
        valid = true;
        break;
    }
    if (!valid) {
      $event.preventDefault();
    }
  }
}
