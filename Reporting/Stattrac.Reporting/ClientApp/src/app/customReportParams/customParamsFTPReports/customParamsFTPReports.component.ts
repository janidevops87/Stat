import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsFTPReportsModel } from './customParamsFTPReportsModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';



@Component({
  templateUrl: './customParamsFTPReports.component.html'
})
export class CustomParamsFTPReportsComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent) {
    
    
  }


  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsFTPReportsModel();
  referralTypeList = [];
  reportGroupId: number;
  subscription: any;

  ngOnInit() {
    this.subscription = this.pc.getreportGroupChangeEmitter().subscribe(item => this.selectedReportGroup(item));
    this.model.ColumnSet = "1";
    this.addtoParameterList();
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

  selectedReportGroup(item: number) {
    this.reportGroupId = item;
    this.getReferralType();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  getReferralType(): void {
    this.model.ReferralTypeID = null;
    this.addtoParameterList();
    this.referralTypeList = [];
    this.appHttpService.get("ReferralTypeDropDown", "?reportGroupId=" + this.reportGroupId).then(res => {
      this.referralTypeList = res;
    });
  }
}
