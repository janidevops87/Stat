import { Component, ViewChild, TemplateRef, HostListener, ElementRef} from '@angular/core';
import { Router, Event, NavigationStart } from '@angular/router';
import { AppHttpService } from '../apphttp.Service';
import { BsModalService, BsModalRef } from 'ngx-bootstrap/modal';
import { Title } from '@angular/platform-browser';
import { Globals } from '../globals.Service';
import { formatDate } from '@angular/common';
import { LogoutModalComponent } from '../logoutmodal/logoutmodal.component';
import { CookieService } from 'ngx-cookie-service';
import { ReportModel } from '../ReportModel';

@Component({
  selector: 'app-reports',
  templateUrl: './reports.component.html',
})
export class ReportsComponent {
  public reportTypes = [];
  public rawReportTypes = []; //before grouped by sections
  modalRef: BsModalRef;
  selectedReportName: string;
  selectedReportUrl: string;
  selectedReportParameterData;
  selectedReportId: number;
  selectedReportFavorite: boolean;
  selectedCustomReportControlName: string;
  reportDateTypeList = [];
  recentReports = [];
  reportFavorites = [];
  reportButtons: any;
  parameterHeader: any;
  passwordExpirationWarning: number;
  passwordExpirationInterval: number = 0;
  passwordExpirationCounter: number = 0;
  showSpinner: boolean;
  ajaxCountInterval: number;
  reportListLoaded: boolean;

  public fileInProgress1: boolean = false; //pdf
  public fileInProgress2: boolean = false; //word
  public fileInProgress3: boolean = false; //excel
  public fileInProgress4: boolean = false; //text
  private reportModel: ReportModel;

  @ViewChild('parametersPopup', { static: false }) parametersPopup: TemplateRef<any>;
  @ViewChild(LogoutModalComponent, { static: false }) public logOutModalComponent: LogoutModalComponent;

  constructor(private router: Router, private appHttpService: AppHttpService,
    private modalService: BsModalService, private titleService: Title,
    public globals: Globals, private cookieService: CookieService) {

  }

  ngOnInit(): void {
    this.router.events.subscribe((event: Event) => {
      if (event instanceof NavigationStart) {
        if (this.logOutModalComponent.parent)
          this.logOutModalComponent.ngOnDestroy();
      }
    });
    window.addEventListener('scroll', this.checkScroll, true);
    this.titleService.setTitle("Reports - Statline Access Portal");

    this.appHttpService.get("usernameandorganization", "").then(res => {
      Globals.userFullName = res["UserFullName"];
      Globals.userOrganizationId = res["UserOrganizationId"];
      Globals.isAuthenticated = true;
      Globals.AutoLogOut = res["AutoLogOut"];
      Globals.AutoLogOutWarning = res["AutoLogOutWarning"];
      Globals.PasswordExpirationWarning = res["PasswordExpirationWarning"];
      Globals.timeZone = res["TimeZone"];
      Globals.canSchedule = res["CanSchedule"];
      this.passwordExpirationWarning = Globals.PasswordExpirationWarning;
      if (this.passwordExpirationWarning) {
        Globals.ShowPasswordChangeNotification = true;
        let dis = this;
        this.passwordExpirationCounter = 9;
        this.passwordExpirationInterval = window.setInterval(function () {
          dis.passwordExpirationCounter--;
        }, 1000);
      }
      Globals.webPersonId = res["WebPersonId"];
      this.appHttpService.get("userReports", "").then(res => {
        const groupBy = function (xs, key) {
          return xs.reduce(function (rv, x) {
            (rv[x[key]] = rv[x[key]] || []).push(x);
            return rv;
          }, {});
        };
        this.reportTypes = groupBy(res, "reportType");
        this.rawReportTypes = res;
        this.getRecentReports(res);

        this.appHttpService.get("favoritereports", "").then(res1 => {
          this.reportListLoaded = true;
          for (var i = 0; i < res1.length; i++) {
            let report = res.filter((value) => {
              return value.reportID == res1[i].reportID ? value : null
            });
            res1[i].reportName = report[0].reportName;
            res1[i].url = report[0].url;
            res1[i].reportType = report[0].reportType;
            res1[i].customReportControlName = report[0].customReportControlName;
            res1[i].lastModified = new Date(res1[i].lastModified.toString() + 'Z');
            res1[i].lastModified = formatDate(res1[i].lastModified, 'MM/dd/yyyy', 'en-US')
          }
          this.reportFavorites = res1;
        });
      }).then().catch(error => {
        console.log(error);
      });
    }).then().catch(error => {
      console.log(error);
      if (error.status == "401") {
        this.router.navigateByUrl("/?returnurl=reports");
      }
    });
  }

  getRecentReports(res: any) {
    this.appHttpService.get("recentreports", "").then(res1 => {
      for (var i = 0; i < res1.length; i++) {
        let report = res.filter((value) => {
          return value.reportID == res1[i].reportID ? value : null;
        });
        res1[i].reportName = report[0].reportName;
        res1[i].url = report[0].url;
        res1[i].reportType = report[0].reportType;
        res1[i].customReportControlName = report[0].customReportControlName;
        res1[i].lastModified = new Date(res1[i].lastModified.toString() + 'Z');
        res1[i].lastModified = formatDate(res1[i].lastModified, 'MM/dd/yyyy', 'en-US');
      }
      this.recentReports = res1;
    });
  }

  ngOnDestroy() {
    window.removeEventListener('scroll', this.checkScroll, true);
  }

  ngAfterViewInit() {
    let dis = this;
    setTimeout(function () {
      if (!Globals.isAuthenticated || !dis.router.url.includes('reports'))
        return;
      dis.logOutModalComponent.startSeconds = Globals.AutoLogOut;
      dis.logOutModalComponent.showModalSeconds = Globals.AutoLogOutWarning;
      dis.logOutModalComponent.parent = 'Reports';
      dis.logOutModalComponent.returnUrl = dis.router.url;
      dis.logOutModalComponent.startTimer();
    }, 10000);
  }

  staticGlobals() {
    return Globals;
  }

  downloadFile(type, params): void {
    window.clearInterval(this.ajaxCountInterval);
    if (this.RequiredFieldsIsEmpty()) {
      return;
    }
    this.reportModel = JSON.parse(this.createReportModelString(params));
    this.reportModel.Format = type;
    if (type === "PDF")
      this.fileInProgress1 = true;
    if (type === "WordOPENXML")
      this.fileInProgress2 = true;
    if (type === "EXCELOPENXML")
      this.fileInProgress3 = true;
    if (type === "TAB")
      this.fileInProgress4 = true;

    this.appHttpService.getFile(this.reportModel)
      .subscribe(x => {
        let mime = "application/pdf";
        let extension = ".pdf";

        if (type === "EXCELOPENXML") {
          mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
          extension = ".xlsx";
        }
        if (type === "WordOPENXML") {
          mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
          extension = ".docx";
        }
        if (type === "TAB") {
          mime = "text/plain";
          extension = ".txt";
        }
        const newBlob = new Blob([x], { type: mime });

        // IE doesn't allow using a blob object directly as link href
        // instead it is necessary to use msSaveOrOpenBlob
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
          window.navigator.msSaveOrOpenBlob(newBlob);
          return;
        }

        // For other browsers: 
        // Create a link pointing to the ObjectURL containing the blob.
        const data = window.URL.createObjectURL(newBlob);

        const link = document.createElement('a');
        link.href = data;
        link.download = this.selectedReportName + extension;
        // this is necessary as link.click() does not work on the latest firefox
        link.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));

        if (type === "PDF")
          this.fileInProgress1 = false;
        if (type === "WordOPENXML")
          this.fileInProgress2 = false;
        if (type === "EXCELOPENXML")
          this.fileInProgress3 = false;
        if (type === "TAB")
          this.fileInProgress4 = false;

        setTimeout(function () {
          // For Firefox it is necessary to delay revoking the ObjectURL
          window.URL.revokeObjectURL(data);
          link.remove();
        }, 100);
      });
  }

  reportView(params): void {
    if (this.RequiredFieldsIsEmpty()) {
      return;
    }
    this.showSpinner = true;
    window.clearInterval(this.ajaxCountInterval);
    let newObj = this.recentReports.filter((value) => {
      return value.reportName == this.selectedReportName ? value : null
    });
    if (this.recentReports.length == 0 || newObj.length == 0) {
      this.recentReports.unshift({
        reportName: this.selectedReportName,
        url: this.selectedReportUrl,
        reportID: this.selectedReportId,
        customReportControlName: this.selectedCustomReportControlName,
        lastModified: formatDate(Date.now(), 'MM/dd/yyyy', 'en-US')
      });
    }
    if (this.recentReports.length > 10)
      this.recentReports.pop();

    this.appHttpService.get("updaterecentreports", "?reportid=" + this.selectedReportId).then(res => {
      this.getRecentReports(this.rawReportTypes);
    });
    let reportModelString = this.createReportModelString(params);
    const paramsId = this.newGuid();
    const url = this.router.serializeUrl(this.router.createUrlTree(['/reportviewer'],
      { queryParams: { "paramsId": paramsId, "reportName": this.selectedReportName } }));
    //save parameters on the server side for security
    this.appHttpService.get("saveparams", "?paramsId=" + paramsId + "&reportModel=" + reportModelString).then(res => {
      let a: HTMLAnchorElement = document.createElement("a");
      document.body.appendChild(a);
      a.href = url;
      a.setAttribute("style", "display:none");
      a.target = "_blank";
      a.click();
      document.body.removeChild(a);
      this.showSpinner = false;
    }).then().catch(error => {
      console.log(error);
      this.showSpinner = false;
    });;
  }

  createReportModelString(params): string {
    return  '{"ReportName": "' + this.selectedReportName + '", "ReportUrl": "' +
      this.selectedReportUrl + '", "Format":"MHTML", "Parameters":' + JSON.stringify(params) + '}';
  }

  openModal(url, name, id, customControlName) {
    this.showSpinner = true;
    this.selectedReportName = name;
    this.selectedReportUrl = url;
    this.selectedReportId = id;
    this.selectedCustomReportControlName = customControlName;
    let newObj = this.reportFavorites.filter((value) => {
      return value.reportName == this.selectedReportName ? value : null
    });
    this.selectedReportFavorite = newObj.length != 0;

    this.modalRef = this.modalService.show(this.parametersPopup, { class: "modal-lg", animated: true });
    this.modalService.onHide.subscribe((reason: string) => {
      window.clearInterval(this.ajaxCountInterval);
    });
    this.reportButtons = document.getElementById("reportButtons");
    this.parameterHeader = document.getElementById("parameterHeader");
    let dis = this;
    this.ajaxCountInterval = window.setInterval(function () {
      dis.showSpinner = getAJAXRequests().length > 0;
    }, 1000);
  }

  RequiredFieldsIsEmpty() {
    let valid = false;
    const requiredFields = document.querySelectorAll("[required]");
    for (let i = 0; i < requiredFields.length; i++) {
      const id = requiredFields[i].id;
      const el = document.getElementById(id) as HTMLInputElement
      let value = '';
      switch (el.localName) {
        case 'input': {
          value = el.value;
          break;
        }
        case 'ng-select': {
          value = el.innerText;
          break;
        }
      }
      if (value === undefined || value === null || value === '') {
        valid = true;
      }
      else {
        valid = false;
      }
    }
    return valid;
  }

  onFavoriteDrop($event) {
    let sortReports = "";
    for (var i = 0; i < this.reportFavorites.length; i++) {
      sortReports += this.reportFavorites[i].reportID + ",";
    }
    sortReports = sortReports.slice(0, sortReports.lastIndexOf(","));
    this.appHttpService.get("updatefavoritereports", "?reportid=0&sortReports=" + sortReports).then(res => {

    });
  }
  updateFavorite() {
    //add favorite
    if (this.selectedReportFavorite) {
      let newObj = this.reportFavorites.filter((value) => {
        return value.reportName == this.selectedReportName ? value : null
      });
      if (newObj.length == 0) {
        this.reportFavorites.push({
          reportName: this.selectedReportName,
          url: this.selectedReportUrl,
          reportID: this.selectedReportId,
          customReportControlName: this.selectedCustomReportControlName,
          lastModified: formatDate(Date.now(), 'MM/dd/yyyy', 'en-US')
        });
        this.reportFavorites = this.reportFavorites.slice();
      }
      this.appHttpService.get("updatefavoritereports", "?reportid=" + this.selectedReportId).then(res => {

      });
    }
    else {
      this.reportFavorites = this.reportFavorites.filter(obj => obj.reportID != this.selectedReportId);
      this.appHttpService.get("deletefavoritereport", "?reportid=" + this.selectedReportId).then(res => {
      });
    }
  }

  onPasswordChangeNotificationClosed(alert1) {
    window.clearInterval(this.passwordExpirationCounter);
    Globals.ShowPasswordChangeNotification = false;
  }

  checkScroll() {
    if (this.parameterHeader) {
      if (this.parameterHeader.getBoundingClientRect().y <= 0) {
        this.reportButtons.classList.add("stickyReportButtons");
        (document.querySelector('#reportButtons') as HTMLElement).style.width = this.parameterHeader.offsetWidth + 'px';
        (document.querySelector('#parameterHeader') as HTMLElement).style.marginBottom = '50px';
        (document.querySelector('#reportButtons') as HTMLElement).style.left = (this.parameterHeader.getBoundingClientRect().left + 15) + 'px';
        (document.querySelector('#reportButtons') as HTMLElement).style.backgroundColor = '#fffcf6';
        (document.querySelector('#secondaryReportHeader') as HTMLElement).style.display = 'block';
      } else {
        this.reportButtons.classList.remove("stickyReportButtons");
        (document.querySelector('#parameterHeader') as HTMLElement).style.marginBottom = '0';
        (document.querySelector('#secondaryReportHeader') as HTMLElement).style.display = 'none';
        (document.querySelector('#reportButtons') as HTMLElement).style.width = 'auto';
        (document.querySelector('#reportButtons') as HTMLElement).style.backgroundColor = 'white';
      }
    }
  }

  newGuid() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      var r = Math.random() * 16 | 0,
        v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }
}

var getAJAXRequests = (function () {
  var oldSend = XMLHttpRequest.prototype.send,
    currentRequests = [];

  XMLHttpRequest.prototype.send = function () {
    currentRequests.push(this); // add this request to the stack
    oldSend.apply(this, arguments); // run the original function

    // add an event listener to remove the object from the array
    // when the request is complete
    this.addEventListener('readystatechange', function () {
      var idx;

      if (this.readyState === XMLHttpRequest.DONE) {
        idx = currentRequests.indexOf(this);
        if (idx > -1) {
          currentRequests.splice(idx, 1);
        }
      }
    }, false);
  };

  return function () {
    return currentRequests;
  }
}());
