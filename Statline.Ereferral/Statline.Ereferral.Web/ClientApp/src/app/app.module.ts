import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent } from './app.component';
import { NgxMaskModule } from 'ngx-mask';
import { NgSelectModule } from '@ng-select/ng-select';
import { AccordionModule } from 'ngx-bootstrap/accordion';
import { TooltipModule } from 'ngx-bootstrap/tooltip';
import { BsModalService } from 'ngx-bootstrap/modal';
import { ModalModule } from 'ngx-bootstrap/modal';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { RecaptchaModule } from 'ng-recaptcha';
import { RecaptchaFormsModule } from 'ng-recaptcha/forms';
import { AppHttpService } from './apphttp.Service';
import { AuthGuard } from './AuthGuard';

import { ReferralComponent } from './referral.component';
import { ConfirmationComponent } from './confirmation.component';
import { ErrorComponent } from './error.component';

const routes: Routes = [
  { path: 'Referral', component: ReferralComponent },
  { path: 'Confirmation', component: ConfirmationComponent },
  { path: 'Error', component: ErrorComponent },
  { path: '', redirectTo: 'Referral', pathMatch: 'full' },
  { path: '**', redirectTo: 'Referral', pathMatch: 'full' }
];
@NgModule({
  declarations: [
    AppComponent,
    ReferralComponent,
    ConfirmationComponent,
    ErrorComponent,
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    BrowserAnimationsModule,
    HttpClientModule,
    FormsModule,
    RouterModule.forRoot(routes),
    NgxMaskModule.forRoot(),
    NgSelectModule,
    AccordionModule,
    TooltipModule.forRoot(),
    ModalModule.forRoot(),
    BsDatepickerModule.forRoot(),
    RecaptchaModule.forRoot(),
    RecaptchaFormsModule,
  ],
  providers: [AppHttpService, AuthGuard, BsModalService],
  bootstrap: [AppComponent]
})
export class AppModule { }
