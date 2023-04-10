import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParams2004ExtendedFTPReportsModel } from './customParams2004ExtendedFTPReportsModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';



@Component({
  templateUrl: './customParams2004ExtendedFTPReports.component.html'
})
export class CustomParams2004ExtendedFTPReportsComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent) {
    this.model.ColumnSet = "2004";
    
  }


  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParams2004ExtendedFTPReportsModel();
  referralTypeList = [];
  reportGroupId: number;
  subscription: any;

  ngOnInit() {
    this.subscription = this.pc.getreportGroupChangeEmitter().subscribe(item => this.selectedReportGroup(item));
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
    this.appHttpService.get("ReferralTypeDropdown", "?reportGroupId=" + this.reportGroupId).then(res => {
      this.referralTypeList = res;
    });
  }
}
