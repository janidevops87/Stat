import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { NgxMaskModule } from 'ngx-mask';
import { ModalModule } from 'ngx-bootstrap/modal';
import { BsDropdownModule, BsDropdownConfig } from 'ngx-bootstrap/dropdown';
import { BsDatepickerModule, BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
import { BsModalService } from 'ngx-bootstrap/modal';
import { SortableModule } from 'ngx-bootstrap/sortable';
import { AlertModule, AlertConfig } from 'ngx-bootstrap/alert';
import { AppComponent } from './app.component';
import { NavMenuComponent } from './nav-menu/nav-menu.component';
import { ReportsComponent } from './reports/reports.component';
import { LoginComponent } from './login/login.component';
import { LogoutModalComponent } from './logoutmodal/logoutmodal.component';
import { ResetPasswordComponent } from './resetpassword/resetpassword.component';
import { NewPasswordComponent } from './newpassword/newpassword.component';
import { ReportViewerComponent } from './reportviewer/reportviewer.component';
import { SchedulingComponent } from './scheduling/scheduling.component';
import { CanDeactivateGuard } from './canDeactivateGuard';
import { NgSelectModule, NgSelectConfig, ɵs } from '@ng-select/ng-select';
import { ParameterDropDownDefault } from './parameterdropdowndefault.service';
import { AppHttpService } from './apphttp.Service';
import { Globals } from './globals.Service';
import { } from './parameterdropdowndefault.service'
import { HelpComponent } from './help/help.component';
import { CookieService } from 'ngx-cookie-service';
import { jqxGridComponent } from 'jqwidgets-ng/jqxgrid';

import { CustomReportsParameterComponent } from './customReportParams/customReportsParameter.component';
import { CustomParamsDisplayTriageFSControlComponent } from './customReportParams/customParamsDisplayTriageFSControl/customParamsDisplayTriageFSControl.component';
import { CustomParameterDirective } from './customReportParams/customParameter.directive';
import { CustomParamsActionableDesignationByEventComponent } from './customReportParams/customParamsActionableDesignationByEvent/customParamsActionableDesignationByEvent.component';
import { CustomParamsActionableDesignationByStatusComponent } from './customReportParams/customParamsActionableDesignationByStatus/customParamsActionableDesignationByStatus.component';
import { CustomParamsActionableDesignationByZipCodeComponent } from './customReportParams/customParamsActionableDesignationByZipCode/customParamsActionableDesignationByZipCode.component';
import { CustomParamsAlertComponent } from './customReportParams/customParamsAlert/customParamsAlert.component';
import { CustomParamsImportOfferActivityComponent } from './customReportParams/customParamsImportOfferActivity/customParamsImportOfferActivity.component';
import { CustomParamsImportStattracUserComponent } from './customReportParams/customParamsImportStattracUser/customParamsImportStattracUser.component';
import { CustomParamsImportEventLogComponent } from './customReportParams/customParamsImportEventLog/customParamsImportEventLog.component';
import { CustomParamsApproacherComponent } from './customReportParams/customParamsApproacher/customParamsApproacher.component';
import { CustomParamsMessageActivityComponent } from './customReportParams/customParamsMessageActivity/customParamsMessageActivity.component';
import { CustomParamsMessageStattracUserComponent } from './customReportParams/customParamsMessageStattracUser/customParamsMessageStattracUser.component';
import { CustomParamsMessageEventComponent } from './customReportParams/customParamsMessageEvent/customParamsMessageEvent.component';
import { CustomParamsReferralTypeComponent } from './customReportParams/customParamsReferralType/customParamsReferralType.component';
import { CustomParamsTrackingNumberAndTypeControlComponent } from './customReportParams/customParamsTrackingNumberAndTypeControl/customParamsTrackingNumberAndTypeControl.component';
import { CustomParamsReferralActivityComponent } from './customReportParams/customParamsReferralActivity/customParamsReferralActivity.component';
import { CustomParamsReferralStatTracUserComponent } from './customReportParams/customParamsReferralStatTracUser/customParamsReferralStatTracUser.component';
import { CustomParamsReferralDetailComponent } from './customReportParams/customParamsReferralDetail/customParamsReferralDetail.component';
import { CustomParamsReferralOutcomeComponent } from './customReportParams/customParamsReferralOutcome/customParamsReferralOutcome.component';
import { CustomParamsScheduleLookupComponent } from './customReportParams/customParamsScheduleLookup/customParamsScheduleLookup.component';
import { CustomParamsProcessorComponent } from './customReportParams/customParamsProcessor/customParamsProcessor.component';
import { CustomParamsHoursBackComponent } from './customReportParams/customParamsHoursBack/customParamsHoursBack.component';
import { CustomParamsOrganizationTypeComponent } from './customReportParams/customParamsOrganizationType/customParamsOrganizationType.component';
import { CustomParamsStartEndMonthYearComponent } from './customReportParams/customParamsStartEndMonthYear/customParamsStartEndMonthYear.component';
import { CustomParamsFTPReportsComponent } from './customReportParams/customParamsFTPReports/customParamsFTPReports.component';
import { CustomParams2004ExtendedFTPReportsComponent } from './customReportParams/customParams2004ExtendedFTPReports/customParams2004ExtendedFTPReports.component';
import { CustomParams2006ExtendedFTPReportsComponent } from './customReportParams/customParams2006ExtendedFTPReports/customParams2006ExtendedFTPReports.component';
import { CustomParamsPersonnelListingComponent } from './customReportParams/customParamsPersonnelListing/customParamsPersonnelListing.component';
import { CustomParamsUploadedReferralStatusComponent } from './customReportParams/customParamsUploadedReferralStatus/customParamsUploadedReferralStatus.component';
import { CustomParamsScreeningCriteriaComponent } from './customReportParams/customParamsScreeningCriteria/customParamsScreeningCriteria.component';
import { ParameterPopupComponent } from './parameter-popup/parameter-popup.component';

@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    ReportsComponent,
    LoginComponent,
    LogoutModalComponent,
    ResetPasswordComponent,
    NewPasswordComponent,
    ReportViewerComponent,
    HelpComponent,
    SchedulingComponent,
    jqxGridComponent,
    CustomReportsParameterComponent,
    CustomParamsDisplayTriageFSControlComponent,
    CustomParameterDirective,
    ParameterPopupComponent,
    CustomParamsActionableDesignationByEventComponent,
    CustomParamsActionableDesignationByStatusComponent,
    CustomParamsActionableDesignationByZipCodeComponent,
    CustomParamsAlertComponent,
    CustomParamsImportOfferActivityComponent,
    CustomParamsImportStattracUserComponent,
    CustomParamsImportEventLogComponent,
    CustomParamsApproacherComponent,
    CustomParamsMessageActivityComponent,
    CustomParamsMessageStattracUserComponent,
    CustomParamsMessageEventComponent,
    CustomParamsReferralTypeComponent,
    CustomParamsTrackingNumberAndTypeControlComponent,
    CustomParamsReferralActivityComponent,
    CustomParamsReferralStatTracUserComponent,
    CustomParamsReferralDetailComponent,
    CustomParamsReferralOutcomeComponent,
    CustomParamsScheduleLookupComponent,
    CustomParamsProcessorComponent,
    CustomParamsHoursBackComponent,
    CustomParamsOrganizationTypeComponent,
    CustomParams2004ExtendedFTPReportsComponent,
    CustomParams2006ExtendedFTPReportsComponent,
    CustomParamsFTPReportsComponent,
    CustomParamsStartEndMonthYearComponent,
    CustomParamsPersonnelListingComponent,
    CustomParamsUploadedReferralStatusComponent,
    CustomParamsScreeningCriteriaComponent
  ],
  entryComponents: [
    CustomParamsDisplayTriageFSControlComponent,
    CustomParamsActionableDesignationByEventComponent,
    CustomParamsActionableDesignationByStatusComponent,
    CustomParamsActionableDesignationByZipCodeComponent,
    CustomParamsAlertComponent,
    CustomParamsImportOfferActivityComponent,
    CustomParamsImportStattracUserComponent,
    CustomParamsImportEventLogComponent,
    CustomParamsApproacherComponent,
    CustomParamsMessageActivityComponent,
    CustomParamsMessageStattracUserComponent,
    CustomParamsMessageEventComponent,
    CustomParamsReferralTypeComponent,
    CustomParamsTrackingNumberAndTypeControlComponent,
    CustomParamsReferralActivityComponent,
    CustomParamsReferralStatTracUserComponent,
    CustomParamsReferralDetailComponent,
    CustomParamsReferralOutcomeComponent,
    CustomParamsScheduleLookupComponent,
    CustomParamsProcessorComponent,
    CustomParamsHoursBackComponent,
    CustomParamsOrganizationTypeComponent,
    CustomParamsStartEndMonthYearComponent,
    CustomParams2004ExtendedFTPReportsComponent,
    CustomParams2006ExtendedFTPReportsComponent,
    CustomParamsFTPReportsComponent,
    CustomParamsPersonnelListingComponent,
    CustomParamsUploadedReferralStatusComponent,
    CustomParamsScreeningCriteriaComponent
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    BrowserAnimationsModule,
    HttpClientModule,
    FormsModule,
    NgSelectModule,
    NgxMaskModule.forRoot(),
    ModalModule.forRoot(),
    BsDropdownModule.forRoot(),
    BsDatepickerModule.forRoot(),
    SortableModule.forRoot(),
    AlertModule.forRoot(),
    RouterModule.forRoot([
      { path: '', component: LoginComponent, pathMatch: 'full' },
      { path: 'login', component: LoginComponent },
      { path: 'resetpassword', component: ResetPasswordComponent },
      { path: 'newpassword', component: NewPasswordComponent },
      { path: 'reportviewer', component: ReportViewerComponent },
      { path: 'reports', component: ReportsComponent },
      { path: 'scheduling', component: SchedulingComponent, canDeactivate: [CanDeactivateGuard] },
      { path: 'help', component: HelpComponent },
      
    ])
  ],
  providers: [AppHttpService, BsModalService, Globals, AlertConfig, BsDropdownConfig,
    BsDatepickerConfig, NgSelectConfig, ɵs, ParameterDropDownDefault, CookieService, CanDeactivateGuard],
  bootstrap: [AppComponent]
})
export class AppModule { }
