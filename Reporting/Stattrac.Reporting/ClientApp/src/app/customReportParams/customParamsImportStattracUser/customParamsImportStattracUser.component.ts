import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsImportStattracUserModel } from './CustomParamsImportStattracUserModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsImportStattracUser.component.html'
})
export class CustomParamsImportStattracUserComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsImportStattracUserModel();
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
