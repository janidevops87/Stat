import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router'
import { AppHttpService } from '../apphttp.Service';
import { Globals } from '../globals.Service';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-resetpassword',
  templateUrl: './resetpassword.component.html'
})
export class ResetPasswordComponent {
  public username = "";
  public resend: boolean = false;
  public showSpinner: boolean = false;
  private sub: any;
  public error = "";
  public message = ""

  constructor(public router: Router, private appHttpService: AppHttpService,
    private route: ActivatedRoute, private titleService: Title, public globals: Globals) {

  }

  ngOnInit(): void {
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.username = params['username'];
        this.message = params['message'];
      });
    this.titleService.setTitle("Reset Password - Statline Access Portal");
  }

  reset() {
    this.showSpinner = true;
    this.appHttpService.get("resetpassword", "?username=" + this.username).then(res => {
      this.resend = true;
      this.showSpinner = false; 
      this.error = "";
    }).then().catch(error => {
      this.error = error.error;
      this.showSpinner = false;
    });
  }

  resendEmail() {
      this.resend = false;
  }
}
