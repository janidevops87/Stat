import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsReferralActivityModel } from './CustomParamsReferralActivityModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';




@Component({
  templateUrl: './customParamsReferralActivity.component.html'
})
export class CustomParamsReferralActivityComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent) {

  }

  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsReferralActivityModel();
  referralTypeList = [];
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

  
}
