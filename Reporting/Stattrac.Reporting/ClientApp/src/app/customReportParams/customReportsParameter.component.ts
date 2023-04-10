
import { Component, Input, OnInit, ViewChild, ComponentFactoryResolver } from '@angular/core';
import { CustomParamsDisplayTriageFSControlComponent } from './customParamsDisplayTriageFSControl/customParamsDisplayTriageFSControl.component';
import { CustomParamItem } from './customParamItem';
import { CustomParameterDirective } from '../customReportParams/customParameter.directive'
import { CustomParamComponent } from './customParam.component';
import { CustomParamsActionableDesignationByEventComponent } from './customParamsActionableDesignationByEvent/customParamsActionableDesignationByEvent.component';
import { CustomParamsActionableDesignationByStatusComponent } from './customParamsActionableDesignationByStatus/customParamsActionableDesignationByStatus.component';
import { CustomParamsActionableDesignationByZipCodeComponent } from './customParamsActionableDesignationByZipCode/customParamsActionableDesignationByZipCode.component';
import { CustomParamsAlertComponent } from './customParamsAlert/customParamsAlert.component';
import { CustomParamsImportOfferActivityComponent } from './customParamsImportOfferActivity/customParamsImportOfferActivity.component';
import { CustomParamsImportStattracUserComponent } from './customParamsImportStattracUser/customParamsImportStattracUser.component';
import { CustomParamsImportEventLogComponent } from './customParamsImportEventLog/customParamsImportEventLog.component';
import { CustomParamsApproacherComponent } from './customParamsApproacher/customParamsApproacher.component';
import { CustomParamsMessageActivityComponent } from './customParamsMessageActivity/customParamsMessageActivity.component';
import { CustomParamsMessageStattracUserComponent } from './customParamsMessageStattracUser/customParamsMessageStattracUser.component';
import { CustomParamsMessageEventComponent } from './customParamsMessageEvent/customParamsMessageEvent.component';
import { CustomParamsReferralTypeComponent } from './customParamsReferralType/customParamsReferralType.component';
import { CustomParamsTrackingNumberAndTypeControlComponent } from './customParamsTrackingNumberAndTypeControl/customParamsTrackingNumberAndTypeControl.component';
import { CustomParamsReferralActivityComponent } from './customParamsReferralActivity/customParamsReferralActivity.component';
import { CustomParamsReferralStatTracUserComponent } from './customParamsReferralStatTracUser/customParamsReferralStatTracUser.component';
import { CustomParamsReferralDetailComponent } from './customParamsReferralDetail/customParamsReferralDetail.component';
import { CustomParamsReferralOutcomeComponent } from './customParamsReferralOutcome/customParamsReferralOutcome.component';
import { CustomParamsScheduleLookupComponent } from './customParamsScheduleLookup/customParamsScheduleLookup.component';
import { CustomParamsProcessorComponent } from './customParamsProcessor/customParamsProcessor.component';
import { CustomParamsHoursBackComponent } from './customParamsHoursBack/customParamsHoursBack.component';
import { CustomParamsOrganizationTypeComponent } from './customParamsOrganizationType/customParamsOrganizationType.component';
import { CustomParamsStartEndMonthYearComponent } from './customParamsStartEndMonthYear/customParamsStartEndMonthYear.component';
import { CustomParamsFTPReportsComponent } from './customParamsFTPReports/customParamsFTPReports.component';
import { CustomParams2004ExtendedFTPReportsComponent } from './customParams2004ExtendedFTPReports/customParams2004ExtendedFTPReports.component';
import { CustomParams2006ExtendedFTPReportsComponent } from './customParams2006ExtendedFTPReports/customParams2006ExtendedFTPReports.component';
import { CustomParamsPersonnelListingComponent } from './customParamsPersonnelListing/customParamsPersonnelListing.component';
import { CustomParamsUploadedReferralStatusComponent } from './customParamsUploadedReferralStatus/customParamsUploadedReferralStatus.component';
import { CustomParamsScreeningCriteriaComponent } from './customParamsScreeningCriteria/customParamsScreeningCriteria.component';


@Component({
  selector: 'reports-customReportsParameter',
  template: '<div ><ng-template customParameterSection> </ng-template></div>'
          
})
export class CustomReportsParameterComponent implements OnInit {
  @Input() customControl: string;
  @ViewChild(CustomParameterDirective, { static: true }) customParameter: CustomParameterDirective;


  constructor(private componentFactoryResolver: ComponentFactoryResolver) { }

  ngOnInit() {
    this.loadComponent();
  }



  loadComponent() {
    let item: CustomParamItem;
    item = this.createCustomControl();
    if (item !== null) {
      const componentFactory = this.componentFactoryResolver.resolveComponentFactory(item.component);

      const viewContainerRef = this.customParameter.viewContainerRef;
      viewContainerRef.clear();

      viewContainerRef.createComponent<CustomParamComponent>(componentFactory);
    }
  }

  createCustomControl(): CustomParamItem {
    switch (this.customControl) {
      case "customParamsDisplayTriageFSControl": {
        return new CustomParamItem(CustomParamsDisplayTriageFSControlComponent);
      }
      case "customParamsActionableDesignationByEvent": {
        return new CustomParamItem(CustomParamsActionableDesignationByEventComponent);
      }
      case "customParamsActionableDesignationByStatus": {
        return new CustomParamItem(CustomParamsActionableDesignationByStatusComponent);
      }
      case "customParamsActionableDesignationByZipCode": {
        return new CustomParamItem(CustomParamsActionableDesignationByZipCodeComponent);
      }
      case "customParamsAlert": {
        return new CustomParamItem(CustomParamsAlertComponent);
      }
      case "customParamsImportOfferActivity": {
        return new CustomParamItem(CustomParamsImportOfferActivityComponent);
      }
      case "customParamsImportStattracUser": {
        return new CustomParamItem(CustomParamsImportStattracUserComponent);
      }
      case "customParamsImportEventLog": {
        return new CustomParamItem(CustomParamsImportEventLogComponent);
      }
      case "customParamsApproacher": {
        return new CustomParamItem(CustomParamsApproacherComponent);
      }
      case "customParamsMessageActivity": {
        return new CustomParamItem(CustomParamsMessageActivityComponent);
      }
      case "customParamsMessageStattracUser": {
        return new CustomParamItem(CustomParamsMessageStattracUserComponent);
      }
      case "customParamsMessageEvent": {
        return new CustomParamItem(CustomParamsMessageEventComponent);
      }
      case "customParamsReferralType": {
        return new CustomParamItem(CustomParamsReferralTypeComponent);
      }
      case "customParamsTrackingNumberAndTypeControl": {
        return new CustomParamItem(CustomParamsTrackingNumberAndTypeControlComponent);
      }
      case "customParamsReferralActivity": {
        return new CustomParamItem(CustomParamsReferralActivityComponent);
      }
      case "customParamsReferralStatTracUser": {
        return new CustomParamItem(CustomParamsReferralStatTracUserComponent);
      }
      case "customParamsReferralDetail": {
        return new CustomParamItem(CustomParamsReferralDetailComponent);
      }
      case "customParamsReferralOutcome": {
        return new CustomParamItem(CustomParamsReferralOutcomeComponent);
      }
      case "customParamsScheduleLookup": {
        return new CustomParamItem(CustomParamsScheduleLookupComponent);
      }
      case "customParamsProcessor": {
        return new CustomParamItem(CustomParamsProcessorComponent);
      }
      case "customParamsHoursBack": {
        return new CustomParamItem(CustomParamsHoursBackComponent);
      }
      case "customParamsOrganizationType": {
        return new CustomParamItem(CustomParamsOrganizationTypeComponent);
      }
      case "customParamsStartEndMonthYear": {
        return new CustomParamItem(CustomParamsStartEndMonthYearComponent);
      }

      case "customParamsFTPReports": {
        return new CustomParamItem(CustomParamsFTPReportsComponent);
      }
      case "customParams2006ExtendedFTPReports": {
        return new CustomParamItem(CustomParams2006ExtendedFTPReportsComponent);
      }
      case "customParams2004ExtendedFTPReports": {
        return new CustomParamItem(CustomParams2004ExtendedFTPReportsComponent);
      }
      case "customParamsPersonnelListing": {
        return new CustomParamItem(CustomParamsPersonnelListingComponent);
      }
      case "customParamsUploadedReferralStatus": {
        return new CustomParamItem(CustomParamsUploadedReferralStatusComponent);
      }
      case "customParamsScreeningCriteria": {
        return new CustomParamItem(CustomParamsScreeningCriteriaComponent);
      }
      default: {
        return null;
      }
    }
  }
  
}
