import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, NavigationEnd, NavigationStart } from '@angular/router'
import { Location } from '@angular/common';
import { AppHttpService } from '../apphttp.Service';
import { Globals } from '../globals.Service';
import { ReportModel } from '../ReportModel';
import { CookieService } from 'ngx-cookie-service';
import { CommonMethods } from '../customReportParams/commonMethods';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css']
})
export class NavMenuComponent {
  isExpanded = false;
  url: string;
  reportName: string;
  reportUrl: string;
  reportID: number;
  paramsId: string;
  urlParams: any;
  customReportControlName: string;
  public fileInProgress1: boolean = false; //pdf
  public fileInProgress2: boolean = false; //word
  public fileInProgress3: boolean = false; //excel
  public fileInProgress4: boolean = false; //text
  private reportModel: ReportModel;
  commonMethods = new CommonMethods();
  private sub: any;

  constructor(public router: Router, public location: Location, public globals: Globals,
    public route: ActivatedRoute, private appHttpService: AppHttpService,
    private cookieService: CookieService) {
    router.events.subscribe((val) => {
      this.url = router.url;
    });

  }
  ngOnInit() {
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.reportName = params['reportName'];
        this.paramsId = params['paramsId'];
        this.reportUrl = params['reportUrl'];
        this.urlParams = params;
      });
    //console.log("i:"+this.location.path());
    const el = document.getElementById('divCopyright') as HTMLElement;
    let year = (new Date()).getFullYear().toString();
    el.innerHTML = "©1996 - " + year + " Statline, A Division of MTF, All rights reserved.";
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  staticGlobals() {
    return Globals;
  }
  collapse() {
    this.isExpanded = false;
  }

  toggle() {
    this.isExpanded = !this.isExpanded;
  }

  downloadFile(type): void {
    this.appHttpService.get("getparams", "?paramsId=" + this.paramsId).then(res => {
      if (this.urlParams["reportUrl"] != undefined && this.urlParams["reportUrl"] != null) {
        let urlStr = JSON.stringify(this.urlParams);
        let tempParams = JSON.parse(urlStr);
        delete tempParams["reportUrl"];
        delete tempParams["reportName"];
        delete tempParams["paramsId"];
        const reportGroupId = res.Parameters.split('|').find(e => e.indexOf("ReportGroupID") > -1);
        const blockEventLog = res.Parameters.split('|').find(e => e.indexOf("BlockEventLog") > -1);
        tempParams["ReportGroupID"] = reportGroupId ? reportGroupId.split('=')[1] : null;
        tempParams["BlockEventLog"] = blockEventLog ? blockEventLog.split('=')[1] : null;
        let paramsStr = this.commonMethods.addtoParameterList(tempParams);
        this.reportModel = JSON.parse(this.createReportModelString(paramsStr));
      }
      else {
        this.reportModel = res;
      }
      this.reportName = this.reportModel.ReportName;
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
          link.download = this.reportName + extension;
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
    });
  }

  createReportModelString(params): string {
    return '{"ReportName": "' + this.reportName + '", "ReportUrl": "' +
      this.reportUrl + '", "Format":"MHTML", "Parameters":"' + params + '"}';
  }
}
