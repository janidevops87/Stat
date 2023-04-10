import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsTrackingNumberAndTypeControlModel } from './CustomParamsTrackingNumberAndTypeControlModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsTrackingNumberAndTypeControl.component.html'
})
export class CustomParamsTrackingNumberAndTypeControlComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    this.appHttpService.get("usernameandorganization", "").then(res => {
      Globals.userFullName = res["UserFullName"];
      Globals.userOrganizationId = res["UserOrganizationId"];
      Globals.isAuthenticated = true;
      Globals.webPersonId = res["WebPersonId"];
      this.getTrackingType();
    }).then().catch(error => {
      console.log(error);
    });

  }

  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsTrackingNumberAndTypeControlModel();
  trackingTypeList = [];

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  getTrackingType(): void {

    this.appHttpService.get("QATrackingTypeDropdown", "?organizationId=" + Globals.userOrganizationId).then(res => {
      this.trackingTypeList = res;
    });
  }

}
