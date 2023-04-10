import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router'
import { AppHttpService } from '../apphttp.Service';
import { Globals } from '../globals.Service';
import { Title } from '@angular/platform-browser';
import { ParameterDropDownDefault } from '../parameterdropdowndefault.service';
import { DateArray } from 'ngx-bootstrap/chronos/types';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html'
})
export class LoginComponent {
  public username = "";
  public password = "";
  public returnUrl = "";
  public message = ""
  public error = "";
  public oldsiteexpiration: number;
  public showSpinner = false;
  public loginCounter = 0;
  private sub: any;

  constructor(public router: Router, private appHttpService: AppHttpService,
    private route: ActivatedRoute, private titleService: Title, public globals: Globals, public pm: ParameterDropDownDefault) {

  }

  ngOnInit(): void {
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.returnUrl = params['returnurl'];
        this.message = params['message'];
      });
    this.titleService.setTitle("Login - Statline Access Portal");

    if (this.message === "Logging out...") {
      this.logout();
    }
    this.appHttpService.get("oldsiteexpiration", "").then(res => {
      let date1: Date = new Date(res.OldSiteExpiration);
      let date2: Date = new Date();
      var diff = date1.getTime() - date2.getTime();
      var diffDays = Math.ceil(diff / (1000 * 3600 * 24));
      this.oldsiteexpiration = diffDays;
    });
  }
  submit() {
    this.showSpinner = true;
    this.appHttpService.post("login", {
      "username": this.username,
      "password": this.password
    }).then(res => {
      this.showSpinner = false;
      Globals.userFullName = res["UserFullName"];
      Globals.userOrganizationId = res["UserOrganizationId"];
      Globals.isAuthenticated = true;
      Globals.AutoLogOut = res["AutoLogOut"];
      Globals.AutoLogOutWarning = res["AutoLogOutWarning"];
      Globals.PasswordExpirationWarning = res["PasswordExpirationWarning"];
      Globals.webPersonId = res["WebPersonId"];
      Globals.timeZone = res["TimeZone"];
      Globals.canSchedule = res["CanSchedule"];

      this.returnUrl = this.route.snapshot.queryParams["returnUrl"];

      if (this.returnUrl === undefined)
        this.router.navigate(["/reports"]);
      else
        this.router.navigate(["/" + this.returnUrl]);
      //setup defaults for dropdowns
      this.pm.setupReportGroupID(res["DefaultReportGroupId"]);
      this.loginCounter = 0;
    }).then().catch(error => {
      this.showSpinner = false;
      if (typeof(error.error) === "string" && error.error.indexOf("newpassword") > 0) {
        this.router.navigateByUrl(error.error);
      }
      if (typeof (error.error) === "string" && error.error.indexOf("Login failed") == 0) {
        this.loginCounter++;
        if (this.loginCounter == 3) {
          this.loginCounter = 0;
          this.router.navigateByUrl('resetpassword?username=' + this.username+'&message=Looks like you have forgotten your password. You can reset it here or go back and try again.');
        }
      }
      if (error.error)
        this.error = error.error;
    });
  }
  logout() {
    this.appHttpService.post("logout", "").then(res => {
      this.message = "You have been logged out successfully.";
      Globals.isAuthenticated = false;
      Globals.userFullName = "";
      Globals.userOrganizationId = 0;
      Globals.webPersonId = 0;
      sessionStorage.clear();
    });
  }

  gotoResetPassword() {
    this.router.navigateByUrl("/resetpassword?username=" + this.username);
  }
}
