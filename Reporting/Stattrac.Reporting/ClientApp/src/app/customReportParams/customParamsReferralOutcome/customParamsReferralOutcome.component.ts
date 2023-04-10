import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsReferralOutcomeModel } from './CustomParamsReferralOutcomeModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';



@Component({
  templateUrl: './customParamsReferralOutcome.component.html'
})
export class CustomParamsReferralOutcomeComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent) {
    this.getCauseOfDeath();
  }
  
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsReferralOutcomeModel();
  referralTypeList = [];
  causeOfDeathList = [];
  reportGroupId: number;
  subscription: any;

  ngOnInit() {
    this.subscription = this.pc.getreportGroupChangeEmitter().subscribe(item => this.selectedReportGroup(item));
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

  selectedReportGroup(item: number) {
    this.reportGroupId = item;
    this.getReferralType();
  }

  getReferralType(): void {
    this.model.ReferralType = null;
    this.addtoParameterList();
    this.referralTypeList = [];
    this.appHttpService.get("PendingReferralTypeDropDown", "?reportGroupId=" + this.reportGroupId).then(res => {
      this.referralTypeList = res;
    });
  }


  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  getCauseOfDeath(): void {
    
    this.appHttpService.get("CauseOfDeathDropdown", "").then(res => {
      this.causeOfDeathList = res;
    });
  }

}
