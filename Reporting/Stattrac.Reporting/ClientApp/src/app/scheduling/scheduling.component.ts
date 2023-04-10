import { Component, ViewChild, TemplateRef, HostListener, ElementRef } from '@angular/core';
import { Router, Event, NavigationStart } from '@angular/router';
import { AppHttpService } from '../apphttp.Service';
import { BsModalService, BsModalRef } from 'ngx-bootstrap/modal';
import { Title } from '@angular/platform-browser';
import { Globals } from '../globals.Service';
import { formatDate } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LogoutModalComponent } from '../logoutmodal/logoutmodal.component';
import { CookieService } from 'ngx-cookie-service';
import { Observable } from 'rxjs';
import { ScheduleModel } from '../ScheduleModel';

@Component({
  selector: 'app-scheduling',
  templateUrl: './scheduling.component.html',
})
export class SchedulingComponent {
  modalRef: BsModalRef;
  EndDateTime: Date;
  EndTime: string;
  StartDateTime: Date;
  StartTime: string;
  dateRangeExceeded: boolean;
  popupDateRangeExceeded: boolean;
  popupRepeatDateExceeded: boolean;
  showSpinner: boolean;
  showPopupSpinner: boolean;
  ddlOrganizationSpinner: boolean;
  ddlScheduleGroupSpinner: boolean;
  showSpinnerForSaveAll: boolean;
  isEditing: boolean = false;
  isSplitting: boolean = false;
  isMultipleSelected: boolean = false;
  isScheduleLocked: boolean = false;
  deletedRowcount: number = 0;
  gaps: number = 0;
  overlaps: number = 0;
  shiftStatusMessage: string;
  invalidDateMessage: string;
  scheduleOrganizationList = [];
  scheduleGroupList = [];
  schedulePeopleList = [];
  selectedOrganization: string;
  scheduleOrganizationId: number;
  scheduleGroup: string;
  scheduleGroupId: number;
  scheduleGroupIdOld: number;
  schedulePopupHeader = 'New Shift';
  schedules: ScheduleModel[];
  buttonSection: any;
  selectedRows: string = "";
  dataChanged: boolean = false;
  deletedRows: string = "";
  changedRows: string = "";
  shiftName: string;
  scheduleItemId: number;
  popupStartDateTime: Date;
  popupStartTime: string;
  popupEndDateTime: Date;
  popupEndTime: string;
  //Split Shift
  shiftName2: string;
  popupStartDateTime2: Date;
  popupStartTime2: string;
  popupEndDateTime2: Date;
  popupEndTime2: string;
  PersonId12: number;
  PersonId22: number;
  PersonId32: number;
  PersonId42: number;
  PersonId52: number;

  repeatUntilDateTime: Date;
  repeatUntilTime: string;
  sunday: boolean = true;
  monday: boolean = true;
  tuesday: boolean = true;
  wednesday: boolean = true;
  thursday: boolean = true;
  friday: boolean = true;
  saturday: boolean = true;
  PersonId1: number;
  PersonId2: number;
  PersonId3: number;
  PersonId4: number;
  PersonId5: number;

  sortColumn: string;
  sortDir_Start: string;
  sortDir_End: string;
  sortDir_Shift: string;
  sortDir_P1: string;
  sortDir_P2: string;
  sortDir_P3: string;
  sortDir_P4: string;
  sortDir_P5: string;

  @ViewChild('schedulePopup', { static: false }) schedulePopup: TemplateRef<any>;
  @ViewChild(LogoutModalComponent, { static: false }) public logOutModalComponent: LogoutModalComponent;

  constructor(public router: Router, private appHttpService: AppHttpService,
    private modalService: BsModalService, private titleService: Title,
    public globals: Globals, private cookieService: CookieService) {

  }

  ngOnInit(): void {
    this.router.events.subscribe((event: Event) => {
      if (event instanceof NavigationStart) {
        if (this.logOutModalComponent.parent)
          this.logOutModalComponent.ngOnDestroy();
        //remove lock
        if (this.scheduleGroupId != undefined) {
          this.appHttpService.get('modifyScheduleLock', '?scheduleGroupId=' + this.scheduleGroupId + "&locktype=1").then(res => {
          });
        }
      }
    });
    this.ddlOrganizationSpinner = true;
    window.addEventListener('scroll', this.checkScroll.bind(this), true);
    let date = new Date();
    let y = date.getFullYear();
    let m = date.getMonth();
    let firstDay = new Date(y, m, 1);
    let lastDay = new Date(y, m + 1, 0);
    this.StartDateTime = firstDay;
    this.StartTime = "00:00";
    this.EndDateTime = lastDay;
    this.EndTime = "23:59";
    this.titleService.setTitle("Scheduling - Statline Access Portal");
    this.schedules = [];

    this.appHttpService.get("usernameandorganization", "").then(res => {
      Globals.userFullName = res["UserFullName"];
      Globals.userOrganizationId = res["UserOrganizationId"];
      Globals.isAuthenticated = true;
      Globals.AutoLogOut = res["AutoLogOut"];
      Globals.AutoLogOutWarning = res["AutoLogOutWarning"];
      Globals.PasswordExpirationWarning = res["PasswordExpirationWarning"];
      Globals.webPersonId = res["WebPersonId"];
      Globals.timeZone = res["TimeZone"];
      Globals.canSchedule = res["CanSchedule"];
      this.getScheduleOrganization();
    }).then().catch(error => {
      console.log(error);
      if (error.status == "401") {
        this.router.navigateByUrl("/?returnurl=reports");
      }
    });
  }

  ngOnDestroy() {
    //remove lock
    if (this.scheduleGroupId != undefined) {
      this.appHttpService.get('modifyScheduleLock', '?scheduleGroupId=' + this.scheduleGroupId + "&locktype=1").then(res => {
      });
    }
  }

  ngAfterViewInit() {
    this.buttonSection = document.getElementById("buttonSection");

    let dis = this;
    setTimeout(function () {
      if (!Globals.isAuthenticated || !dis.router.url.includes('schedul') || dis.logOutModalComponent.seconds != undefined)
        return;
      dis.logOutModalComponent.startSeconds = Globals.AutoLogOut;
      dis.logOutModalComponent.showModalSeconds = Globals.AutoLogOutWarning;
      dis.logOutModalComponent.parent = 'Schedules';
      dis.logOutModalComponent.returnUrl = dis.router.url;
      dis.logOutModalComponent.startTimer();
    }, 10000);
  }

  staticGlobals() {
    return Globals;
  }

  openModal(message) {
    if (this.isScheduleLocked)
      return;
    if (message) {
      if (message == "Split") {
        if (this.selectedRows == '' || this.isMultipleSelected || this.dataChanged)
          return;
        this.isSplitting = true;
        this.scheduleItemId = Number.parseInt(this.selectedRows.slice(0, -1));
        this.shiftName = (document.getElementById("lnkShiftName_" + this.scheduleItemId) as HTMLElement).innerHTML.trim();
        this.shiftName2 = this.shiftName;
        let start = (document.getElementById("tdShiftStart_" + this.scheduleItemId) as HTMLElement).innerHTML.trim().split(' ');
        let end = (document.getElementById("tdShiftEnd_" + this.scheduleItemId) as HTMLElement).innerHTML.trim().split(' ');;
        this.popupStartDateTime = new Date(start[0]);
        this.popupStartTime = start[1];
        this.popupEndDateTime = undefined;
        this.popupEndTime = undefined;

        this.popupStartDateTime2 = undefined;
        this.popupStartTime2 = undefined;
        this.popupEndDateTime2 = new Date(end[0]);
        this.popupEndTime2 = end[1];

        this.PersonId1 = Number.parseInt((document.getElementById("p1_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId2 = Number.parseInt((document.getElementById("p2_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId3 = Number.parseInt((document.getElementById("p3_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId4 = Number.parseInt((document.getElementById("p4_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId5 = Number.parseInt((document.getElementById("p5_" + this.scheduleItemId) as HTMLInputElement).value);

        this.PersonId12 = Number.parseInt((document.getElementById("p1_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId22 = Number.parseInt((document.getElementById("p2_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId32 = Number.parseInt((document.getElementById("p3_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId42 = Number.parseInt((document.getElementById("p4_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId52 = Number.parseInt((document.getElementById("p5_" + this.scheduleItemId) as HTMLInputElement).value);

        this.schedulePopupHeader = "Split Shift";
      }
      else {
        this.isEditing = true;
        this.scheduleItemId = message;
        this.shiftName = (document.getElementById("lnkShiftName_" + this.scheduleItemId) as HTMLElement).innerHTML.trim();
        let start = (document.getElementById("tdShiftStart_" + this.scheduleItemId) as HTMLElement).innerHTML.trim().split(' ');
        this.popupStartDateTime = new Date(start[0]);
        this.popupStartTime = start[1];
        let end = (document.getElementById("tdShiftEnd_" + this.scheduleItemId) as HTMLElement).innerHTML.trim().split(' ');;
        this.popupEndDateTime = new Date(end[0]);
        this.popupEndTime = end[1];
        this.PersonId1 = Number.parseInt((document.getElementById("p1_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId2 = Number.parseInt((document.getElementById("p2_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId3 = Number.parseInt((document.getElementById("p3_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId4 = Number.parseInt((document.getElementById("p4_" + this.scheduleItemId) as HTMLInputElement).value);
        this.PersonId5 = Number.parseInt((document.getElementById("p5_" + this.scheduleItemId) as HTMLInputElement).value);
        this.schedulePopupHeader = "Edit Shift";
      }
    }
    else {
      this.appHttpService.get('SchedulePeople', '?organizationId=' + this.scheduleOrganizationId +
        '&scheduleGroupId=' + this.scheduleGroupId).then(res0 => {
          this.schedulePeopleList = res0;
          this.schedulePeopleList.unshift({ value: -1, label: " " });
        });
      this.isEditing = false;
      this.shiftName = undefined;
      this.popupStartDateTime = new Date();
      this.popupStartTime = "00:00";
      this.popupEndDateTime = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
      this.popupEndTime = "23:59";
      this.PersonId1 = undefined;
      this.PersonId2 = undefined;
      this.PersonId3 = undefined;
      this.PersonId4 = undefined;
      this.PersonId5 = undefined;
      this.schedulePopupHeader = "New Shift";
      this.repeatUntilDateTime = undefined;
      this.repeatUntilTime = undefined;
      this.monday = true;
      this.tuesday = true;
      this.wednesday = true;
      this.thursday = true;
      this.friday = true;
      this.saturday = true;
      this.sunday = true;
    }
    this.modalRef = this.modalService.show(this.schedulePopup, { class: "modal-lg", animated: true });
    this.modalService.onHide.subscribe((reason: string) => {
      this.isEditing = false;
      this.isSplitting = false;
      this.shiftStatusMessage = undefined;
      this.invalidDateMessage = undefined;
      this.popupDateRangeExceeded = false;
      this.popupRepeatDateExceeded = false;
      this.repeatUntilDateTime = undefined;
      this.repeatUntilTime = undefined;
    });
  }

  getScheduleOrganization(): void {
    this.ddlOrganizationSpinner = true;
    const params = "?OrganizationId=" + Globals.userOrganizationId;
    this.scheduleOrganizationList = [];
    this.appHttpService.get("ScheduleOrganizationsDropdown", params).then(res => {
      this.scheduleOrganizationList = res;
      let prevSelected = this.cookieService.get("selectedScheduleOrganization");
      if (prevSelected && prevSelected != "") {
        this.scheduleOrganizationId = Number.parseInt(prevSelected);
        this.OrganizationChanged();
      }
      this.ddlOrganizationSpinner = false;
    }).then().catch(error => {
      this.ddlOrganizationSpinner = false;
    });
  }

  getScheduleGroups(): void {
    this.ddlScheduleGroupSpinner = true;
    this.scheduleGroupList = [];
    this.scheduleGroupId = null;
    let org = Globals.userOrganizationId;
    if (this.scheduleOrganizationId !== undefined && this.scheduleOrganizationId !== null) {
      org = this.scheduleOrganizationId;
    }
    const params = "?OrganizationId=" + org;
    this.appHttpService.get("ScheduleGroupsDropdown", params).then(res => {
      this.scheduleGroupList = res;
      this.ddlScheduleGroupSpinner = false;
    }).then().catch(error => {
      this.ddlScheduleGroupSpinner = false;
    });;
  }

  OrganizationChanged() {
    let selected = this.scheduleOrganizationList.find(x => x.value == this.scheduleOrganizationId);
    if (selected) {
      this.selectedOrganization = selected.label;
      this.cookieService.set("selectedScheduleOrganization", this.scheduleOrganizationId.toString(), 3650);
      this.getScheduleGroups();
    }
  }

  scheduleGroupChanged() {
    let selected = this.scheduleGroupList.find(x => x.value == this.scheduleGroupId);
    if (selected) {
      this.scheduleGroup = selected.label.toString().trim();
      if (this.scheduleGroupIdOld)
        this.appHttpService.get('modifyScheduleLock', '?scheduleGroupId=' + this.scheduleGroupIdOld + "&locktype=1").then(res => {
        });
      this.scheduleGroupIdOld = this.scheduleGroupId;
    }
  }

  popUpClearPeople() {
    this.PersonId1 = undefined;
    this.PersonId2 = undefined;
    this.PersonId3 = undefined;
    this.PersonId4 = undefined;
    this.PersonId5 = undefined;
  }

  popUpClearPeople2() {
    this.PersonId12 = undefined;
    this.PersonId22 = undefined;
    this.PersonId32 = undefined;
    this.PersonId42 = undefined;
    this.PersonId52 = undefined;
  }

  checkLockAndSearch() {
    this.showSpinner = true;
    this.appHttpService.get('modifyScheduleLock', '?scheduleGroupId=' + this.scheduleGroupId + "&locktype=0").then(res => {
      this.isScheduleLocked = false;
      this.search();
    }).then().catch(error => {
      if (error.status == "401") {
        this.isScheduleLocked = true;
        this.search();
      }
      else {
        console.log(error);
        this.showSpinner = false;
      }
    });
  }

  search(updateItemId?:number) {
    let diff = Math.abs(this.EndDateTime.getTime() - this.StartDateTime.getTime());
    let diffDays = Math.ceil(diff / (1000 * 3600 * 24));
    if (diffDays >= 365) {
      this.dateRangeExceeded = true;
      this.showSpinner = false;
      this.schedules = [];
      return;
    }
    else
      this.dateRangeExceeded = false;

    this.shiftStatusMessage = undefined;
    this.sortColumn = undefined;
    this.selectedRows = "";
    this.deletedRowcount = 0;
    this.changedRows = "";
    this.deletedRows = "";
    if (this.StartTime.indexOf(':') < 1)
      this.StartTime = this.StartTime.substring(0, 2) + ':' + this.StartTime.substring(2);
    if (this.EndTime.indexOf(':') < 1)
      this.EndTime = this.EndTime.substring(0, 2) + ':' + this.EndTime.substring(2);

    this.appHttpService.get('SchedulePeople', '?organizationId=' + this.scheduleOrganizationId +
      '&scheduleGroupId=' + this.scheduleGroupId).then(res0 => {
        this.schedulePeopleList = res0;
        this.schedulePeopleList.unshift({ value: -1, label: " " });
        let params = "?organizationId=" + this.scheduleOrganizationId +
          "&scheduleGroupId=" + this.scheduleGroupId +
          "&startDt=" + formatDate(formatDate(this.StartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.StartTime, 'MM/dd/yyyy HH:mm', 'en-US') +
          "&endDt=" + formatDate(formatDate(this.EndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.EndTime, 'MM/dd/yyyy HH:mm', 'en-US'); +
            this.appHttpService.get("Schedules", params).then(res => {
              this.schedules = res;
              this.gaps = res.filter(function (el) { return el.shiftStatus == 2 }).length;
              this.overlaps = res.filter(function (el) { return el.shiftStatus == 1 }).length;
              let cbAll = document.getElementById("cb_All") as HTMLInputElement;
              cbAll.checked = false;
              this.dataChanged = false;
              this.showSpinner = false;
              this.showSpinnerForSaveAll = false;
              let dis = this;
              setTimeout(function () {
                if (updateItemId)
                  dis.rowToggleByCellClick(updateItemId);
              }, 200);
           
            }).then().catch(error => {
              console.log(error);
              this.showSpinner = false;
            });
      }).then().catch(error => {
        console.log(error);
        this.showSpinner = false;
      });
  }

  createShift() {
    if (this.scheduleOrganizationId == undefined || this.scheduleGroupId == undefined || this.dataChanged)
      return;
    if (this.popupStartTime.indexOf(':') < 1)
      this.popupStartTime = this.popupStartTime.substring(0, 2) + ':' + this.popupStartTime.substring(2);
    if (this.popupEndTime.indexOf(':') < 1)
      this.popupEndTime = this.popupEndTime.substring(0, 2) + ':' + this.popupEndTime.substring(2);

    let formated_popupStartDate = formatDate(formatDate(this.popupStartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupEndDate = formatDate(formatDate(this.popupEndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupStartDate_forComparison = formatDate(formatDate(this.popupStartDateTime, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupStartTime, 'yyyy-MM-dd HH:mm', 'en-US');
    let formated_popupEndDate_forComparison = formatDate(formatDate(this.popupEndDateTime, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupEndTime, 'yyyy-MM-dd HH:mm', 'en-US');

    if (formated_popupEndDate_forComparison <= formated_popupStartDate_forComparison) {
      this.invalidDateMessage = "End date cannot be before the start date.";
      this.showPopupSpinner = false;
      return;
    }
    else {
      this.invalidDateMessage = undefined;
    }

    if (this.repeatUntilDateTime) {
      let diff1 = Math.abs(Date.now() - this.repeatUntilDateTime.getTime());
      let diffDays1 = Math.ceil(diff1 / (1000 * 3600 * 24));
      if (diffDays1 >= 365) {
        this.popupRepeatDateExceeded = true;
        return;
      }
      else
        this.popupRepeatDateExceeded = false;
    }

    let repatEnd = "";
    let weekDays = "";
    if (this.repeatUntilDateTime && this.repeatUntilTime && this.repeatUntilTime != "") {
      if (this.repeatUntilTime && this.repeatUntilTime.indexOf(':') < 1)
        this.repeatUntilTime = this.repeatUntilTime.substring(0, 2) + ':' + this.repeatUntilTime.substring(2);
      repatEnd = formatDate(formatDate(this.repeatUntilDateTime, 'MM/dd/yyyy', 'en-US') + ' ' +
        (this.repeatUntilTime || '00:00'), 'MM/dd/yyyy HH:mm', 'en-US');
      weekDays += this.sunday ? "1" : "0";
      weekDays += this.monday ? "1" : "0";
      weekDays += this.tuesday ? "1" : "0";
      weekDays += this.wednesday ? "1" : "0";
      weekDays += this.thursday ? "1" : "0";
      weekDays += this.friday ? "1" : "0";
      weekDays += this.saturday ? "1" : "0";
    }
    else {
      weekDays = "0000000";
    }

    let shiftParams = "?shiftName=" + this.shiftName +
      "&scheduleGroupId=" + this.scheduleGroupId +
      "&startDt=" + formated_popupStartDate + "&endDt=" + formated_popupEndDate +
      "&PersonId1=" + (this.PersonId1 == -1 ? "" : this.PersonId1) + "&PersonId2=" + (this.PersonId2 == -1 ? "" : this.PersonId2) +
      "&PersonId3=" + (this.PersonId3 == -1 ? "" : this.PersonId3) + "&PersonId4=" + (this.PersonId4 == -1 ? "" : this.PersonId4) +
      "&PersonId5=" + (this.PersonId5 == -1 ? "" : this.PersonId5) +
      "&repeatEnd=" + repatEnd + "&weekDays=" + weekDays;

    if (this.shiftStatusMessage == undefined) {
      let params = "?organizationId=" + this.scheduleOrganizationId +
        "&scheduleGroupId=" + this.scheduleGroupId + "&scheduleItemId=" + this.scheduleItemId +
        "&startDt=" + formatDate(formatDate(this.popupStartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime, 'MM/dd/yyyy HH:mm', 'en-US') +
        "&endDt=" + formatDate(formatDate(this.popupEndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime, 'MM/dd/yyyy HH:mm', 'en-US');

      this.appHttpService.get("shiftstatus", params).then(res => {
        this.showPopupSpinner = false;
        if (res == 1) {
          this.shiftStatusMessage = "This shift overlaps with another shift.<br>" +
            "You can still save your changes by clicking the Save button.";
        } else if (res == 2) {
          this.shiftStatusMessage = "This shift has gaps.<br>" +
            "You can still save your changes by clicking the Save button.";
        } else { //no collapse or gap, so just save
          this.showPopupSpinner = true;
          this.appHttpService.get("createschedule", shiftParams).then(res => {
            this.search();
            this.modalRef.hide();
            this.showPopupSpinner = false;
          });
        }
      });
    }
    else { // already checked shiftstatus, now save the shift
      this.showPopupSpinner = true;
      this.appHttpService.get("createschedule", shiftParams).then(res => {
        this.search();
        this.modalRef.hide();
        this.showPopupSpinner = false;
      });
    }
  }

  updateShift() {
    if (this.popupStartTime.indexOf(':') < 1)
      this.popupStartTime = this.popupStartTime.substring(0, 2) + ':' + this.popupStartTime.substring(2);
    if (this.popupEndTime.indexOf(':') < 1)
      this.popupEndTime = this.popupEndTime.substring(0, 2) + ':' + this.popupEndTime.substring(2);

    let formated_popupStartDate = formatDate(formatDate(this.popupStartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupEndDate = formatDate(formatDate(this.popupEndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupStartDate_forComparison = formatDate(formatDate(this.popupStartDateTime, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupStartTime, 'yyyy-MM-dd HH:mm', 'en-US');
    let formated_popupEndDate_forComparison = formatDate(formatDate(this.popupEndDateTime, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupEndTime, 'yyyy-MM-dd HH:mm', 'en-US');

    if (formated_popupEndDate_forComparison <= formated_popupStartDate_forComparison) {
      this.invalidDateMessage = "End date cannot be before the start date.";
      this.showPopupSpinner = false;
      return;
    }
    else {
      this.invalidDateMessage = undefined;
    }
    let shiftParams = "?scheduleItemID=" + this.scheduleItemId + "&shiftName=" + this.shiftName +
      "&scheduleGroupId=" + this.scheduleGroupId +
      "&startDt=" + formated_popupStartDate + "&endDt=" + formated_popupEndDate +
      "&PersonId1=" + (this.PersonId1 == -1 ? "" : this.PersonId1) + "&PersonId2=" + (this.PersonId2 == -1 ? "" : this.PersonId2) +
      "&PersonId3=" + (this.PersonId3 == -1 ? "" : this.PersonId3) + "&PersonId4=" + (this.PersonId4 == -1 ? "" : this.PersonId4) +
      "&PersonId5=" + (this.PersonId5 == -1 ? "" : this.PersonId5);

    if (this.shiftStatusMessage == undefined) {
      let params = "?organizationId=" + this.scheduleOrganizationId +
        "&scheduleGroupId=" + this.scheduleGroupId + "&scheduleItemId=" + this.scheduleItemId +
        "&startDt=" + formatDate(formatDate(this.popupStartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime, 'MM/dd/yyyy HH:mm', 'en-US') +
        "&endDt=" + formatDate(formatDate(this.popupEndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime, 'MM/dd/yyyy HH:mm', 'en-US');
      this.appHttpService.get("shiftstatus", params).then(res => {
        this.showPopupSpinner = false;
        if (res == 1) {
          this.shiftStatusMessage = "This shift overlaps with another shift.<br>" +
            "You can still save your changes by clicking the Save button.";
        } else if (res == 2) {
          this.shiftStatusMessage = "This shift has gaps.<br>" +
            "You can still save your changes by clicking the Save button.";
        } else { //no collapse or gap, so just update
          this.showPopupSpinner = true;
          this.appHttpService.get("updateschedule", shiftParams).then(res => {
            let tempId = this.scheduleItemId;
            this.doneUpdating();
            this.showPopupSpinner = false;
            this.search(tempId);
          });
        }
      });
    }
    else { // already checked shiftstatus, now update the shift
      this.showPopupSpinner = true;
      this.appHttpService.get("updateschedule", shiftParams).then(res => {
        let tempId = this.scheduleItemId;
        this.doneUpdating();
        this.showPopupSpinner = false;
        this.search(tempId);
      });
    }
  }

  doneUpdating() {
    (document.getElementById("lnkShiftName_" + this.scheduleItemId) as HTMLElement).innerHTML = this.shiftName;
    (document.getElementById("tdShiftStart_" + this.scheduleItemId) as HTMLInputElement).innerHTML = formatDate(formatDate(this.popupStartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime, 'MM/dd/yyyy HH:mm', 'en-US');
    (document.getElementById("tdShiftEnd_" + this.scheduleItemId) as HTMLInputElement).innerHTML = formatDate(formatDate(this.popupEndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime, 'MM/dd/yyyy HH:mm', 'en-US');
    (document.getElementById("p1_" + this.scheduleItemId) as HTMLInputElement).value = this.PersonId1 ? this.PersonId1.toString() : undefined;
    (document.getElementById("p1_" + this.scheduleItemId) as HTMLInputElement).style.backgroundColor = "white";
    (document.getElementById("p2_" + this.scheduleItemId) as HTMLInputElement).value = this.PersonId2 ? this.PersonId2.toString() : undefined;
    (document.getElementById("p2_" + this.scheduleItemId) as HTMLInputElement).style.backgroundColor = "white";
    (document.getElementById("p3_" + this.scheduleItemId) as HTMLInputElement).value = this.PersonId3 ? this.PersonId3.toString() : undefined;
    (document.getElementById("p3_" + this.scheduleItemId) as HTMLInputElement).style.backgroundColor = "white";
    (document.getElementById("p4_" + this.scheduleItemId) as HTMLInputElement).value = this.PersonId4 ? this.PersonId4.toString() : undefined;
    (document.getElementById("p4_" + this.scheduleItemId) as HTMLInputElement).style.backgroundColor = "white";
    (document.getElementById("p5_" + this.scheduleItemId) as HTMLInputElement).value = this.PersonId5 ? this.PersonId5.toString() : undefined;
    (document.getElementById("p5_" + this.scheduleItemId) as HTMLInputElement).style.backgroundColor = "white";
    this.scheduleItemId = undefined;
    this.shiftStatusMessage = undefined;
    this.modalRef.hide();
    this.isEditing = false;
  }

  createSplitShift() {
    if (this.popupStartTime.indexOf(':') < 1)
      this.popupStartTime = this.popupStartTime.substring(0, 2) + ':' + this.popupStartTime.substring(2);
    if (this.popupEndTime.indexOf(':') < 1)
      this.popupEndTime = this.popupEndTime.substring(0, 2) + ':' + this.popupEndTime.substring(2);

    if (this.popupStartTime2.indexOf(':') < 1)
      this.popupStartTime2 = this.popupStartTime2.substring(0, 2) + ':' + this.popupStartTime2.substring(2);
    if (this.popupEndTime2.indexOf(':') < 1)
      this.popupEndTime2 = this.popupEndTime2.substring(0, 2) + ':' + this.popupEndTime2.substring(2);

    let formated_popupStartDate = formatDate(formatDate(this.popupStartDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupEndDate = formatDate(formatDate(this.popupEndDateTime, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupStartDate2 = formatDate(formatDate(this.popupStartDateTime2, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupStartTime2, 'MM/dd/yyyy HH:mm', 'en-US');
    let formated_popupEndDate2 = formatDate(formatDate(this.popupEndDateTime2, 'MM/dd/yyyy', 'en-US') + ' ' + this.popupEndTime2, 'MM/dd/yyyy HH:mm', 'en-US')

    let formated_popupStartDate_forComparison = formatDate(formatDate(this.popupStartDateTime, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupStartTime, 'yyyy-MM-dd HH:mm', 'en-US');
    let formated_popupEndDate_forComparison = formatDate(formatDate(this.popupEndDateTime, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupEndTime, 'yyyy-MM-dd HH:mm', 'en-US');
    let formated_popupEndDate2_forComparison = formatDate(formatDate(this.popupEndDateTime2, 'yyyy-MM-dd', 'en-US') + ' ' + this.popupEndTime2, 'yyyy-MM-dd HH:mm', 'en-US')

    if (formated_popupEndDate_forComparison <= formated_popupStartDate_forComparison) {
      this.invalidDateMessage = "Split date cannot be before the start date.";
      this.showPopupSpinner = false;
      return;
    }

    if (formated_popupEndDate_forComparison > formated_popupEndDate2_forComparison) {
      this.invalidDateMessage = "Split date cannot be later than the end date.";
      this.showPopupSpinner = false;
      return;
    }
    let createparams = "?shiftName=" + this.shiftName2 + "&scheduleGroupId=" + this.scheduleGroupId +
      "&startDt=" + formated_popupStartDate2 + "&endDt=" + formated_popupEndDate2 +
      "&PersonId1=" + (this.PersonId12 == -1 ? "" : this.PersonId12) + "&PersonId2=" + (this.PersonId22 == -1 ? "" : this.PersonId22) +
      "&PersonId3=" + (this.PersonId32 == -1 ? "" : this.PersonId32) + "&PersonId4=" + (this.PersonId42 == -1 ? "" : this.PersonId42) +
      "&PersonId5=" + (this.PersonId52 == -1 ? "" : this.PersonId52) + "&repeatEnd=&weekDays=0000000";

    let updateParams = "?scheduleItemID=" + this.scheduleItemId + "&shiftName=" + this.shiftName +
      "&scheduleGroupId=" + this.scheduleGroupId +
      "&startDt=" + formated_popupStartDate + "&endDt=" + formated_popupEndDate +
      "&PersonId1=" + (this.PersonId1 == -1 ? "" : this.PersonId1) + "&PersonId2=" + (this.PersonId2 == -1 ? "" : this.PersonId2) +
      "&PersonId3=" + (this.PersonId3 == -1 ? "" : this.PersonId3) + "&PersonId4=" + (this.PersonId4 == -1 ? "" : this.PersonId4) +
      "&PersonId5=" + (this.PersonId5 == -1 ? "" : this.PersonId5);

    this.showPopupSpinner = true;
    this.appHttpService.get("createschedule", createparams).then(res => {
      this.appHttpService.get("updateschedule", updateParams).then(res => {
        this.modalRef.hide();
        this.search();
        this.showPopupSpinner = false;
      });
    });

  }

  saveChanges() {
    this.showSpinnerForSaveAll = true;
    this.dataChanged = false;
    //get count of updates, can't send too many at once or it doesn't always save, save in chunks
    let saveString = this.getItemsToSave();

    this.appHttpService.get("saveschedulechanges", "?updates=" + encodeURIComponent(saveString) + "&deletes=" + this.deletedRows).then(res => {
      //check to see if there is more to save
      if (this.changedRows.length > 0) {
        this.deletedRows = "";
        this.saveChanges();
      }
      else {
        this.search();
      }
    }).then().catch(error => {
      console.log(error);
      this.showSpinnerForSaveAll = false;
    });;
  }

  getItemsToSave() {
    let index = -1;
    let saveString = '';

    if (this.changedRows.match(/&/g).length > 20) {
      const pattern = '&';
      let position = 20;
      const l = this.changedRows.length;
      
      while (position-- && index++ < l) {
        index = this.changedRows.indexOf(pattern, index);
        if (index < 0)
          break;
      }

      saveString = this.changedRows.substring(0, index + 1);
      this.changedRows = this.changedRows.substring(index + 1);
    }
    else {
      saveString = this.changedRows;
      this.changedRows = "";
    }

    return saveString;
  }

  popUpSave() {
    let diff = Math.abs(this.popupEndDateTime.getTime() - this.popupStartDateTime.getTime());
    let diffDays = Math.ceil(diff / (1000 * 3600 * 24));
    if (diffDays >= 365) {
      this.popupDateRangeExceeded = true;
      return;
    }
    else
      this.popupDateRangeExceeded = false;

    this.invalidDateMessage = undefined;
    this.showPopupSpinner = true;

    if (this.isEditing)
      this.updateShift();
    else if (this.isSplitting)
      this.createSplitShift();
    else
      this.createShift();
  }

  personChange(event) {
    this.dataChanged = true;
    let ddl = (document.getElementById(event.target.id) as HTMLInputElement);
    ddl.style.backgroundColor = '#fdf3e6';
    this.updateChangedRows(ddl);
  }

  private updateChangedRows(ddl: HTMLInputElement) {
    let id = ddl.getAttribute("id");
    let scheduleItemId = id.substring(id.indexOf("_") + 1);
    let person = id.substring(0, id.indexOf("_"));

    //update data source for sorting
    let schedule = this.schedules.find(a => a.scheduleItemID == Number.parseInt(scheduleItemId));
    switch (person) {
      case "p1":
        schedule.person1 = this.schedulePeopleList.find(a => a.value == ddl.value).label;
        schedule.personId1 = Number.parseInt(ddl.value);
        break;
      case "p2":
        schedule.person2 = this.schedulePeopleList.find(a => a.value == ddl.value).label;
        schedule.personId2 = Number.parseInt(ddl.value);
        break;
      case "p3":
        schedule.person3 = this.schedulePeopleList.find(a => a.value == ddl.value).label;
        schedule.personId3 = Number.parseInt(ddl.value);
        break;
      case "p4":
        schedule.person4 = this.schedulePeopleList.find(a => a.value == ddl.value).label;
        schedule.personId4 = Number.parseInt(ddl.value);
        break;
      case "p5":
        schedule.person5 = this.schedulePeopleList.find(a => a.value == ddl.value).label;
        schedule.personId5 = Number.parseInt(ddl.value);
        break;
      default:
        break;
    }

    let personNumber = id.substring(0, id.indexOf("_"));
    if (this.changedRows.indexOf(scheduleItemId) < 0) {
      this.changedRows += scheduleItemId + "=" + personNumber + ":" + ddl.value + ",&";
    }
    else {
      //12345=P1:100,P2:200,&
      let rowStr = this.changedRows.substring(this.changedRows.indexOf(scheduleItemId), this.changedRows.indexOf("&", this.changedRows.indexOf(scheduleItemId)));
      let newRow = "";
      if (rowStr.indexOf(personNumber) > 1) {
        let prevPersonId = rowStr.substring(rowStr.indexOf(personNumber + ":") + 3, rowStr.indexOf(",", rowStr.indexOf(personNumber + ":") + 1) + 1);
        newRow = rowStr.replace(personNumber + ":" + prevPersonId, personNumber + ":" + ddl.value + ",");
      }
      else {
        newRow = rowStr.replace("=", "=" + personNumber + ":" + ddl.value + ",");
      }
      this.changedRows = this.changedRows.replace(rowStr, newRow);
    }
  }

  deleteShift() {
    if (this.selectedRows == '' || this.isScheduleLocked)
      return;
    let deleted = this.selectedRows.slice(0, -1).split(",");
    for (let i = 0; i < deleted.length; i++) {
      let row = document.getElementById("row_" + deleted[i]) as HTMLElement;
      row.remove();
      //Discard all changes from changed rows since the row is deleted
      //12345=P1:100,P2:200,&
      if (this.changedRows.indexOf(deleted[i] + "=") > -1) {
        let deleteFromChangedRows = this.changedRows.substring(this.changedRows.indexOf(deleted[i] + "="),
          this.changedRows.indexOf("&", this.changedRows.indexOf(deleted[i] + "=")) + 1);
        this.changedRows = this.changedRows.replace(deleteFromChangedRows, "");
      }
    }
    this.deletedRowcount += deleted.length;
    this.deletedRows += this.selectedRows;
    this.dataChanged = true;
    this.selectedRows = "";
  }

  clearPeople() {
    if (this.selectedRows == '' || this.isScheduleLocked)
      return;
    let selected = this.selectedRows.slice(0, -1).split(",");
    for (let i = 0; i < selected.length; i++) {
      let ddl = document.getElementById("p1_" + selected[i]) as HTMLInputElement;
      if (ddl.value != "-1") {
        ddl.value = "-1";
        ddl.style.backgroundColor = '#fdf3e6';
        this.updateChangedRows(ddl);
      }
      ddl = document.getElementById("p2_" + selected[i]) as HTMLInputElement;
      if (ddl.value != "-1") {
        ddl.value = "-1";
        ddl.style.backgroundColor = '#fdf3e6';
        this.updateChangedRows(ddl);
      }
      ddl = document.getElementById("p3_" + selected[i]) as HTMLInputElement;
      if (ddl.value != "-1") {
        ddl.value = "-1";
        ddl.style.backgroundColor = '#fdf3e6';
        this.updateChangedRows(ddl);
      }
      ddl = document.getElementById("p4_" + selected[i]) as HTMLInputElement;
      if (ddl.value != "-1") {
        ddl.value = "-1";
        ddl.style.backgroundColor = '#fdf3e6';
        this.updateChangedRows(ddl);
      }
      ddl = document.getElementById("p5_" + selected[i]) as HTMLInputElement;
      if (ddl.value != "-1") {
        ddl.value = "-1";
        ddl.style.backgroundColor = '#fdf3e6';
        this.updateChangedRows(ddl);
      }
    }
    this.dataChanged = true;
  }

  rowClick(event) {
    if (event.target.id.indexOf("td_") == 0) { //td containing the checkbox clicked, treat as checkbox clicked 
      this.rowToggleByCellClick(event.target.id.replace("td_", ""));
      return;
    }
    if (event.target.id.indexOf("cb_") == 0) //ignore checkbox
      return;
    let id = event.target.parentNode.id.replace("row_", "");
    if (id == "") //clicked on dropdown
      id = event.target.parentNode.parentNode.id.replace("row_", "");
    let rows = document.getElementsByClassName("tblRow");
    let cbAll = document.getElementById("cb_All") as HTMLInputElement;
    cbAll.checked = false;
    for (let i = 0; i < rows.length; i++) {
      let rowId = rows[i].getAttribute("id").replace("row_", "");
      if (id == rowId) {
        let cbSelected = document.getElementById("cb_" + rowId) as HTMLInputElement;
        cbSelected.checked = true;
        this.selectedRows = id + ",";
        rows[i].classList.add("selectedRow");
        continue;
      }
      rows[i].classList.remove("selectedRow");
      let cb = document.getElementById("cb_" + rowId) as HTMLInputElement;
      cb.checked = false;
    }
    this.isMultipleSelected = this.selectedRows.slice(0, -1).split(',').length > 1;
  }

  rowToggled(event) {
    let id = event.target.id.replace("cb_", "");
    if (id == "All") {
      this.selectedRows = "";
      if (event.currentTarget.checked) {
        let rows = document.getElementsByClassName("tblRow");
        for (let i = 0; i < rows.length; i++) {
          let rowId = rows[i].getAttribute("id").replace("row_", "");
          rows[i].classList.add("selectedRow");
          let cb = document.getElementById("cb_" + rowId) as HTMLInputElement;
          cb.checked = true;
          this.selectedRows += rowId + ",";
        }
      }
      else {
        let rows = document.getElementsByClassName("tblRow");
        for (let i = 0; i < rows.length; i++) {
          let rowId = rows[i].getAttribute("id").replace("row_", "");
          let cb = document.getElementById("cb_" + rowId) as HTMLInputElement;
          rows[i].classList.remove("selectedRow");
          cb.checked = false;
          this.selectedRows = "";
        }
      }
    }
    else {
      let cbAll = document.getElementById("cb_All") as HTMLInputElement;
      cbAll.checked = false;
      let row = document.getElementById("row_" + id) as HTMLElement;
      if (event.currentTarget.checked) {
        this.selectedRows += id + ",";
        row.classList.add("selectedRow");
      }
      else {
        this.selectedRows = this.selectedRows.replace(id + ",", "");
        row.classList.remove("selectedRow");
      }
    }
    this.isMultipleSelected = this.selectedRows.slice(0, -1).split(',').length > 1;
  }

  rowToggleByCellClick(id) {
    let cbAll = document.getElementById("cb_All") as HTMLInputElement;
    let cb = document.getElementById("cb_" + id) as HTMLInputElement;
    cbAll.checked = false;
    let row = document.getElementById("row_" + id) as HTMLElement;
    if (!cb.checked) {
      cb.checked = true;
      this.selectedRows += id + ",";
      row.classList.add("selectedRow");
    }
    else {
      cb.checked = false;
      this.selectedRows = this.selectedRows.replace(id + ",", "");
      row.classList.remove("selectedRow");
    }
  }

  sort(column) {
    this.resetSort(column);
    if (column == "shift") {
      this.sortColumn = "shift";
      if (this.sortDir_Shift == undefined || this.sortDir_Shift == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) { return (a.scheduleItemName <= b.scheduleItemName) ? -1 : 1; });
        this.sortDir_Shift = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) { return (a.scheduleItemName >= b.scheduleItemName) ? -1 : 1; });
        this.sortDir_Shift = "&#x25BC;";
      }
    }
    if (column == "start") {
      this.sortColumn = "start";
      if (this.sortDir_Start == undefined || this.sortDir_Start == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) { return (a.shiftStart <= b.shiftStart) ? -1 : 1; });
        this.sortDir_Start = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) { return (a.shiftStart >= b.shiftStart) ? -1 : 1; });
        this.sortDir_Start = "&#x25BC;";
      }
    }
    if (column == "end") {
      this.sortColumn = "end";
      if (this.sortDir_End == undefined || this.sortDir_End == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) { return (a.shiftEnd <= b.shiftEnd) ? -1 : 1; });
        this.sortDir_End = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) { return (a.shiftEnd >= b.shiftEnd) ? -1 : 1; });
        this.sortDir_End = "&#x25BC;";
      }
    }
    if (column == "p1") {
      this.sortColumn = "p1";
      if (this.sortDir_P1 == undefined || this.sortDir_P1 == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person1 || "") <= (b.person1 || "")) ? -1 : 1;
        });
        this.sortDir_P1 = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person1 || "") >= (b.person1 || "")) ? -1 : 1;
        });
        this.sortDir_P1 = "&#x25BC;";
      }
    }
    if (column == "p2") {
      this.sortColumn = "p2";
      if (this.sortDir_P2 == undefined || this.sortDir_P2 == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person2 || "") <= (b.person2 || "")) ? -1 : 1;
        });
        this.sortDir_P2 = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person2 || "") >= (b.person2 || "")) ? -1 : 1;
        });
        this.sortDir_P2 = "&#x25BC;";
      }
    }
    if (column == "p3") {
      this.sortColumn = "p3";
      if (this.sortDir_P3 == undefined || this.sortDir_P3 == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person3 || "") <= (b.person3 || "")) ? -1 : 1;
        });
        this.sortDir_P3 = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person3 || "") >= (b.person3 || "")) ? -1 : 1;
        });
        this.sortDir_P3 = "&#x25BC;";
      }
    }
    if (column == "p4") {
      this.sortColumn = "p4";
      if (this.sortDir_P4 == undefined || this.sortDir_P4 == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person4 || "") <= (b.person4 || "")) ? -1 : 1;
        });
        this.sortDir_P4 = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person4 || "") >= (b.person4 || "")) ? -1 : 1;
        });
        this.sortDir_P4 = "&#x25BC;";
      }
    }
    if (column == "p5") {
      this.sortColumn = "p5";
      if (this.sortDir_P5 == undefined || this.sortDir_P5 == "&#x25BC;") {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person5 || "") <= (b.person5 || "")) ? -1 : 1;
        });
        this.sortDir_P5 = "&#x25B2;";
      } else {
        this.schedules = this.schedules.sort(function (a, b) {
          return ((a.person5 || "") >= (b.person5 || "")) ? -1 : 1;
        });
        this.sortDir_P5 = "&#x25BC;";
      }
    }
  }

  resetSort(except) {
    if (except != this.sortColumn)
      this.sortColumn = undefined;
    if (except != this.sortColumn)
      this.sortDir_Start = undefined;
    if (except != this.sortColumn)
      this.sortDir_End = undefined;
    if (except != this.sortColumn)
      this.sortDir_Shift = undefined;
    if (except != this.sortColumn)
      this.sortDir_P1 = undefined;
    if (except != this.sortColumn)
      this.sortDir_P2 = undefined;
    if (except != this.sortColumn)
      this.sortDir_P3 = undefined;
    if (except != this.sortColumn)
      this.sortDir_P4 = undefined;
    if (except != this.sortColumn)
      this.sortDir_P5 = undefined;
  }

  popupStartDateChange() {
    this.shiftStatusMessage = undefined;
  }

  popupEndDateChange() {
    this.popupStartDateTime2 = this.popupEndDateTime;
    this.shiftStatusMessage = undefined;
  }

  popupEndTimeChange() {
    this.popupStartTime2 = this.popupEndTime;
    this.shiftStatusMessage = undefined;
  }

  timeKeyDown($event): void {
    let nums = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Backspace", "ArrowRight", "ArrowLeft", "Delete"];
    if (nums.find(x => x == $event.key) == undefined)
      return;
    var target = $event.target || $event.srcElement || $event.currentTarget;
    let val = target.value;
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

  @HostListener('window:beforeunload', ['$event'])
  beforeUnload(event): string {
    // returning true will navigate without confirmation
    // returning false will show a confirm dialog before navigating away

    if (this.dataChanged && (this.logOutModalComponent.seconds == undefined ||
      this.logOutModalComponent.seconds > 0)) {
      event.returnValue = 'You have unsaved changes! If you leave, your changes will be lost.';
      return event.returnValue;
    } else {
      //remove lock
      if (this.scheduleGroupId != undefined) {
        this.appHttpService.get('modifyScheduleLock', '?scheduleGroupId=' + this.scheduleGroupId + "&locktype=1").then(res => {
        });
      }
    }
  }

  checkScroll() {
    if (this.router.url.indexOf("schedu") < 0)
      return;
    if (window.pageYOffset >= 230) {
      if (this.buttonSection) {
        this.buttonSection.classList.add("stickyScheduleButtons");
      }
      (document.querySelector('#divSchedules') as HTMLElement).style.marginTop = '100px';
    } else {
      if (this.buttonSection) {
        this.buttonSection.classList.remove("stickyScheduleButtons");
      }
      (document.querySelector('#divSchedules') as HTMLElement).style.marginTop = '0';
    }
  }

  get searchTitle() {
    if (this.dataChanged) {
      return "Either save or cancel your changes before doing another search.";
    }
    if (this.scheduleGroupId == undefined || this.EndDateTime == undefined ||
      this.EndTime == undefined || this.EndTime == '' || this.StartDateTime == undefined ||
      this.StartTime == undefined || this.StartTime == '') {
      return "Please fill out all the required fields";
    }
    return 'Search';
  }

  get clearPeopleTitle() {
    if (this.isScheduleLocked)
      return 'Schedule Group is locked, you cannot make any changes.';
    if (this.selectedRows == '')
      return 'Please select at least one row to clear people.';
    else
      return 'Clear all the dropdowns for selected rows.';
  }

  get deleteTitle() {
    if (this.isScheduleLocked)
      return 'Schedule Group is locked, you cannot make any changes.';
    if (this.selectedRows == '')
      return 'Please select at least one row to delete.';
    else
      return 'Delete selected rows.';
  }

  get splitShiftTitle() {
    if (this.isScheduleLocked)
      return 'Schedule Group is locked, you cannot make any changes.';

    if (this.selectedRows == '')
      return 'Please select a shift to split.';
    if (this.isMultipleSelected)
      return 'Please select only one shift to split.';
    if (this.dataChanged == true)
      return 'Either save or cancel your changes before splitting a shift.';
    else
      return 'Split a shift';
  }

  get newShiftTitle() {
    if (this.isScheduleLocked)
      return 'Schedule Group is locked, you cannot make any changes.';
    if (this.scheduleOrganizationId == undefined || this.scheduleGroupId == undefined ||
      this.EndDateTime == undefined || this.EndTime == undefined || this.EndTime == '' ||
      this.StartDateTime == undefined || this.StartTime == undefined || this.StartTime == '')
      return "Please fill out all the required fields.";
    if (this.dataChanged == true)
      return 'Either save or cancel your changes before creating a new shift.';
    else
      return 'New shift';
  }

  setRowTitle(shitStatus) {
    if (shitStatus == 1)
      return "Overlap";
    if (shitStatus == 2)
      return "Gap";
    return ""
  }
}


