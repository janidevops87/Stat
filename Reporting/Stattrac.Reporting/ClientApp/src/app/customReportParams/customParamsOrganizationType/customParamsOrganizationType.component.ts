import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsOrganizationTypeModel } from './CustomParamsOrganizationTypeModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';



@Component({
  templateUrl: './customParamsOrganizationType.component.html'
})
export class CustomParamsOrganizationTypeComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService) {
    this.getOrganizationType();
  }
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsOrganizationTypeModel();
  organizationTypeList = [];

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  getOrganizationType(): void {

    this.appHttpService.get("OrganizationTypeDropdown", "").then(res => {
      this.organizationTypeList = res;
    });
  }

}
