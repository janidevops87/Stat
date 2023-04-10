import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsReferralTypeModel } from './CustomParamsReferralTypeModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';



@Component({
  templateUrl: './customParamsReferralType.component.html'
})
export class CustomParamsReferralTypeComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsReferralTypeModel();
  referralTypeList = [];
  reportGroupId: number;
  subscription: any;

  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent) {

  }

  ngOnInit() {
    this.subscription = this.pc.getreportGroupChangeEmitter().subscribe(item => this.selectedReportGroup(item));
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

  selectedReportGroup(item: number) {
    this.reportGroupId = item;
    this.getReferralType();
    this.model.ReferralType = 0;
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
