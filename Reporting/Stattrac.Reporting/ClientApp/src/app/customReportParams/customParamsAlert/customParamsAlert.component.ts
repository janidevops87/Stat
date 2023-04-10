import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsAlertModel } from './CustomParamsAlertModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';



@Component({
  templateUrl: './customParamsAlert.component.html'
})
export class CustomParamsAlertComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent) {

  }

  ngOnInit() {
    this.subscription = this.pc.getsourceCodeChangeEmitter().subscribe(item => this.selectedSourceCode(item));
    this.getAlertGroup();
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsAlertModel();
  alertTypeList = [{ value: 1, label: 'Referrals' }, { value: 2, label: 'Messages' }, { value: 4, label: 'Import Offers' }];;
  alertList = [];
  sourceCodeName: string;
  subscription: any;

  selectedSourceCode(item: string) {
    this.sourceCodeName = item;
    this.getAlertGroup();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  getAlertGroup(): void {
    let params = "";
    let start = "?";
    if (this.model.AlertTypeID !== undefined && this.model.AlertTypeID !== null) {
      params = start + "alertTypeId=" + this.model.AlertTypeID;
      start = "&";
    }
    if (this.sourceCodeName !== undefined && this.sourceCodeName !== null) {
      params += start + 'sourceCodeName=' + this.sourceCodeName;
    }
    this.model.AlertID = null;
    this.addtoParameterList();
    this.alertList = [];
    this.appHttpService.get("AlertGroupDropdown", params).then(res => {
      this.alertList = res;
    });
  }

  alertTypeChanged() {
    this.getAlertGroup();
    this.addtoParameterList();
  }

}
