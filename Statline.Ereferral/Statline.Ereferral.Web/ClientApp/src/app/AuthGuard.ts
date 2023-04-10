import { Injectable } from '@angular/core';
import { Router, CanActivate, ActivatedRouteSnapshot } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { ReferralModel } from './model';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private router: Router) { }

  canActivate(route: ActivatedRouteSnapshot) {
    return true;
    let model: ReferralModel = JSON.parse(sessionStorage.getItem("ReferralModel"));
    if (model !== null && model.authorizationCode.length === 6) {
      return true;
    }
    this.router.navigate(['/']);
    return false;
  }
}
