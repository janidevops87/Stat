import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router'
import { AppHttpService } from '../apphttp.Service';
import { Globals } from '../globals.Service';
import { Title } from '@angular/platform-browser';
import { ValidationErrors, AbstractControl } from '@angular/forms';

@Component({
  selector: 'app-newpassword',
  templateUrl: './newpassword.component.html'
})
export class NewPasswordComponent {
  public title = "Password Reset";
  public username = "";
  public token = "";
  public expired = "";
  public changeRequested = "";
  public error = "";
  public requestNotValid = "";
  public message = "";
  public password = "";
  public passwordOld = "";
  public passwordConfirm = "";
  public passwordHasChanged: boolean = false;
  private sub: any;

  constructor(public router: Router, private appHttpService: AppHttpService,
    private route: ActivatedRoute, private titleService: Title, public globals: Globals) {

  }

  ngOnInit(): void {
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.username = params['username'];
        this.token = params['token'];
        this.expired = params['expired'] || 0;
        this.changeRequested = params['changeRequested'] || 0;
      });
    this.titleService.setTitle("Set New Password - Statline Access Portal");

    if (this.expired === "1") {
      this.message ="Your password is either expired or reset by the administrator. Please set a new password."
    }

    if (this.changeRequested === "1") {
      this.title = "Change Password";
      this.appHttpService.get("validatepasswordchangerequest", "").then(res => {
        this.requestNotValid = "";
      }).then().catch(error => {
        this.requestNotValid = error.error;
      });
    }
    else {
      this.title = "Password Reset";
      this.appHttpService.get("validateresetrequest", "?username=" + this.username + "&token=" + this.token).then(res => {
        this.requestNotValid = "";
      }).then().catch(error => {
        this.requestNotValid = error.error;
      });
    }
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  reset() {
    this.router.navigateByUrl("/resetpassword");
  }

  gotoLogin() {
    this.router.navigateByUrl("/");
  }

  isPasswordValid(): string {
    let ret = "";
    if (this.password.length < 8) {
      ret += "At least 8 characters.<br>"
    }
    if (this.password !== this.passwordConfirm) {
      ret +=  "Passwords should match.<br>"
    }
    let arr = [];
    arr = this.password.match(/\d/);
    if (arr === null) {
      ret +=  "At least 1 number.</br>"
    }

    arr = this.password.match(/[a-z]/);
    if (arr ===null) {
      ret += "At least 1 lower case character.<br>"
    }

    arr = this.password.match(/[A-Z]/);
    if (arr === null) {
      ret += "At least 1 upper case character.</br>"
    }

    arr = this.password.match(/[*@!$#%&()^~{}]+/);
    if (arr === null) {
      ret += "At least 1 special character.<br>"
    }

    return ret === '' ? "ok" : ret;
  }

  setPassword() {
    if (this.changeRequested == '0')
      this.passwordOld = '';
    this.appHttpService.get("setpassword", "?username=" + (this.username || '') +
      "&password=" + encodeURIComponent(this.password) + "&passwordOld=" +
      (this.passwordOld = '' ? '' : encodeURIComponent(this.passwordOld))).then(res => {
        this.passwordHasChanged = true;
        this.message = null;
    }).then().catch(error => {
      this.error = error.error;
    });
  }
}
