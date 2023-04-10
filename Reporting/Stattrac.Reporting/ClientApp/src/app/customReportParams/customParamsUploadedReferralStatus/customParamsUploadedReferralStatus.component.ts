import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsUploadedReferralStatusModel } from './CustomParamsUploadedReferralStatusModel';
import { CommonMethods } from '../commonMethods';



@Component({
  templateUrl: './customParamsUploadedReferralStatus.component.html'
})
export class CustomParamsUploadedReferralStatusComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsUploadedReferralStatusModel();
  statusList = [{ value: 0, label: 'Pending' }, { value: 1, label: 'Success' }, { value: 2, label: 'Failure' }];

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
