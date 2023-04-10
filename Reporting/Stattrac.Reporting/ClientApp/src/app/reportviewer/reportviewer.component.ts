import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router, Event, NavigationStart  } from '@angular/router';
import { AppHttpService } from '../apphttp.Service';
import { Title } from '@angular/platform-browser';
import { LogoutModalComponent } from '../logoutmodal/logoutmodal.component';
import { Globals } from '../globals.Service';
import { ReportModel } from '../ReportModel';
import { CookieService } from 'ngx-cookie-service';
import { CommonMethods } from '../customReportParams/commonMethods';

@Component({
  selector: 'app-report-component',
  templateUrl: './reportviewer.component.html'
})
export class ReportViewerComponent {
  public error: string = null;
  public reportLoaded: boolean = false;
  private reportModel: ReportModel;
  public reportName: string;
  public reportUrl: string;
  public paramsId: string;
  public urlParams: any;
  private sub: any;
  commonMethods = new CommonMethods();

  @ViewChild(LogoutModalComponent, { static: false }) public logOutModalComponent: LogoutModalComponent;

  constructor(private router: Router, private route: ActivatedRoute,
    private appHttpService: AppHttpService, private titleService: Title,
    private globals: Globals, private cookieService: CookieService) {

  }

  ngOnInit(): void {
    this.router.events.subscribe((event: Event) => {
      if (event instanceof NavigationStart) {
        if (this.logOutModalComponent.parent)
          this.logOutModalComponent.ngOnDestroy();
      }
    });
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.paramsId = params['paramsId'];
        this.reportName = params['reportName'];
        this.reportUrl = params['reportUrl'];
        this.urlParams = params;
      });
    this.appHttpService.get("usernameandorganization", "").then(res1 => {
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
        this.titleService.setTitle(this.reportModel.ReportName + " - Stattrac Reporting");
        Globals.userFullName = res1["UserFullName"];
        Globals.userOrganizationId = res1["UserOrganizationId"];
        Globals.isAuthenticated = true;
        Globals.AutoLogOut = res1["AutoLogOut"];
        Globals.AutoLogOutWarning = res1["AutoLogOutWarning"];
        Globals.PasswordExpirationWarning = res1["PasswordExpirationWarning"];
        Globals.webPersonId = res1["WebPersonId"];
        Globals.timeZone = res1["TimeZone"];
        Globals.canSchedule = res1["CanSchedule"];
        this.viewReport(this.reportModel);
      }).then().catch(error => {
        if (error.status == "404") { //when paramsId not found on the server side cache
          this.error = error.error;
          this.reportLoaded = true;
          return;
        }
      });
    }).then().catch(error => {
      console.log(error);
      if (error.status == "401") {
        this.router.navigateByUrl("/");
      }
      if (error.error.indexOf("auth") > 0) {
        this.router.navigateByUrl('/message=You are auto logged off due to inactivity.');
      }
    });
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  ngAfterViewInit() {
    let dis = this;
    setTimeout(function () {
      if (!Globals.isAuthenticated || !dis.router.url.includes('reportviewer'))
        return;
      dis.logOutModalComponent.startSeconds = Globals.AutoLogOut;
      dis.logOutModalComponent.showModalSeconds = Globals.AutoLogOutWarning;
      dis.logOutModalComponent.parent = dis.reportModel.ReportName;
      dis.logOutModalComponent.returnUrl = dis.router.url;
      dis.logOutModalComponent.startTimer();
    }, 10000);
  }

  viewReport(reportModel: ReportModel): void {
    this.appHttpService.getRawText(reportModel).then(res => {
      const el = document.getElementById('html') as HTMLElement;
      const reg = /!paramsId!/gi;
      el.innerHTML = res.replace(reg, this.paramsId);
      let imgs = el.getElementsByTagName("img");
      //make sure report has an image in it
      if (imgs.length > 0) {
        let logo = imgs[0].src;
        for (let i = 0; i < imgs.length; i++) {
          if (imgs[i].src == "cid:")
            imgs[i].style.display = "none";
          else {
            if (imgs[i].src.startsWith("cid:") && imgs[i].src.length > 10)
              imgs[i].src = logo;
            imgs[i].style.width = "100%";
          }
        }
      }

      let divs = el.getElementsByTagName('div');
      for (var i = 0; i < divs.length; i++) {
        divs[i].setAttribute("style", "word-break:break-word;");
      }

      this.error = null;
      this.reportLoaded = true;

    }).then().catch(error => {
      console.log(error);
      this.error = error.error || 'An error occured. Please try again.';
      this.reportLoaded = true;
      if (error.url.toLowerCase().indexOf('returnurl') > 0) {
        this.router.navigateByUrl('/?message=You have been logged out due to inactivity.');
      }
    });
  }

  createReportModelString(params): string {
    return '{"ReportName": "' + this.reportName + '", "ReportUrl": "' +
      this.reportUrl + '", "Format":"MHTML", "Parameters":"' + params + '"}';
  }
}
