import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsReferralStatTracUserModel } from './CustomParamsReferralStatTracUserModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsReferralStatTracUser.component.html'
})
export class CustomParamsReferralStatTracUserComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsReferralStatTracUserModel();
  userList = [];

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    this.getStatTracUsers();
  }

  getStatTracUsers(): void {
    const params = "?userOrgId=" + Globals.userOrganizationId;
    this.userList = [];
    this.addtoParameterList();
    this.appHttpService.get("StatTracUserDropDown", params).then(res => {
      this.userList = res;
    });
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  CallIDIsValid() {
    if (this.model.CallID === undefined || this.model.CallID === null || this.model.CallID === '') {
      return false;
    }
    return true;
  }
}
