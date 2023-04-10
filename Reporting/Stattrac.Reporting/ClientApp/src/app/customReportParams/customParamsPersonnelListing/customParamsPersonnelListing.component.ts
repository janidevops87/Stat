import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsPersonnelListingModel } from './CustomParamsPersonnelListingModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsPersonnelListing.component.html'
})
export class CustomParamsPersonnelListingComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsPersonnelListingModel();
  stateList = [];
  typeList = [];
  orgList = [];

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    this.getStateList();
    this.getTypeList();
  }

  getStateList(): void {
    this.stateList = [];
    this.addtoParameterList();
    this.appHttpService.get("StateDropDown", '').then(res => {
      this.stateList = res;
    });
  }

  getTypeList(): void {
    this.typeList = [];
    this.addtoParameterList();
    this.appHttpService.get("OrganizationTypeDropdown", '').then(res => {
      this.typeList = res;
    });
  }

  getOrganizationList(): void {
    this.orgList = [];
    if ((this.model.StateId !== undefined && this.model.StateId !== null) || (this.model.OrganizationTypeId !== undefined && this.model.OrganizationTypeId !== null)){
      let params = "";
      if (this.model.StateId !== undefined && this.model.StateId !== null) {
        params = "stateId=" + this.model.StateId;
      }
      if (this.model.OrganizationTypeId !== undefined && this.model.OrganizationTypeId !== null) {
        if (params.length === 0) {
          params = "organizationTypeId=" + this.model.OrganizationTypeId;
        }
        else {
          params = "&organizationTypeId=" + this.model.OrganizationTypeId;
        }
      }
      this.appHttpService.get("OrganizationByStateAndTypeDropDown", "?" + params).then(res => {
        this.orgList = res;
      });
    }

  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  OrganizationIsValid() {
    if (this.model.OrganizationID === undefined || this.model.OrganizationID === null ) {
      return false;
    }
    return true;
  }

}
