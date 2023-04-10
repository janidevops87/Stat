import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsMessageStattracUserModel } from './CustomParamsMessageStattracUserModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsMessageStattracUser.component.html'
})
export class CustomParamsMessageStattracUserComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsMessageStattracUserModel();
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

}
