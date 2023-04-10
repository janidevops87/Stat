import { Injectable, OnInit } from '@angular/core';
import { AppHttpService } from '../app/apphttp.Service';
import { Router } from '@angular/router';


@Injectable()
export class Globals {
  public static isAuthenticated: boolean = false;
  public static userFullName: string = "";
  public static userOrganizationId: number;
  public static webPersonId: number;
  public static AutoLogOut: number;
  public static AutoLogOutWarning: number;
  public static PasswordExpirationWarning: number;
  public static ShowPasswordChangeNotification: boolean = false;
  public static timeZone: string;
  public static canSchedule: number;
  
  constructor(public appHttpService: AppHttpService, private router: Router ) {

  }

  checkAuth() {
    this.appHttpService.get("usernameandorganization", "").then(res => {
      Globals.isAuthenticated = true;
      Globals.userFullName = res["UserFullName"];
      Globals.userOrganizationId = res["UserOrganizationId"];
      Globals.webPersonId = res["WebPersonId"];
      Globals.AutoLogOut = res["AutoLogOut"];
      Globals.AutoLogOutWarning = res["AutoLogOutWarning"];
      Globals.PasswordExpirationWarning = res["PasswordExpirationWarning"];
      Globals.timeZone = res["TimeZone"];
      Globals.canSchedule = res["CanSchedule"];

    }).then().catch(error => {
      console.log('Global auth error');
      console.log(error);
      Globals.isAuthenticated = false;
      Globals.userFullName = "";
      Globals.userOrganizationId = 0;
      Globals.webPersonId = 0;
      Globals.timeZone = "";
      this.router.navigateByUrl('/');
    });
  }

}
