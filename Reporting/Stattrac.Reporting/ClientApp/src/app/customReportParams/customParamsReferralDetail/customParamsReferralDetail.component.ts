import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsReferralDetailModel } from './CustomParamsReferralDetailModel';
import { CommonMethods } from '../commonMethods';



@Component({
  templateUrl: './customParamsReferralDetail.component.html'
})
export class CustomParamsReferralDetailComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsReferralDetailModel();
  secondarySortList = [{ value: 'Alphabetical', label: 'Alphabetical Order' }, { value: 'Case', label: 'Case Order' }];

  ngOnInit() {
    this.model.DisplayEventLog = true;
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
