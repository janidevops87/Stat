import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AppHttpService } from './apphttp.Service';
import { ReferralModel } from './model';

@Component({ templateUrl: './emailVerification.component.html' })
export class EmailVerificationComponent {
  url = 'api/EmailVerification';
  model = new ReferralModel();
  validationErrors = {};
  showSpinner: boolean = false;
  isProcessing: boolean = false;

  constructor(private router: Router, private appHttpService: AppHttpService) {
    this.model = JSON.parse(sessionStorage.getItem("ReferrralModel"));
  }

  isValid(control) {
    if (control.touched) {
      if (this.isValidControl(control)) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }

  isValidControl(control): boolean {
    if (control.touched) {
      if (!control.valid) {
        return false;
      }
      else if (this.validationErrors != null && this.validationErrors[control.name] != null) {
        return false;
      }
    }
    return true;
  }

  formIsValid(loginForm) {
    return (loginForm.valid);
  }

  clearServerErrors(control): void {
    this.validationErrors[control.name] = null;
  }

  verifyCode(verifyForm) {
    let self = this;
    self.isProcessing = true;
    self.showSpinner = true;
    this.appHttpService.get("api/Server/Log?message=EmailVerificationClicked:" + (self.model.facilityEreferralCode || ""), "");
    this.appHttpService.post(self.url, self.model)
      .then(result => {
        self.isProcessing = false;
        self.showSpinner = false;
        sessionStorage.setItem("ReferrralModel", JSON.stringify(self.model));
        //if (self.model.redirect=='new')
        //  self.router.navigateByUrl('/Offer');
        //else
        //  self.router.navigateByUrl('/UpdateOffer');
      }).catch(msg => {
        self.showSpinner = false;
        self.isProcessing = false;
        self.validationErrors = msg.json();
        //if (++self.model.loginCounter > 3) {
        //  self.router.navigateByUrl('/ContactIiam');
        //}
      });
  }
}
