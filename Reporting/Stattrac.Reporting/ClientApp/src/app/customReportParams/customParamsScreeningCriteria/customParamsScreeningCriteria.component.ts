import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsScreeningCriteriaModel } from './CustomParamsScreeningCriteriaModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsScreeningCriteria.component.html'
})
export class CustomParamsScreeningCriteriaComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsScreeningCriteriaModel();
  criteriaGroupList = [];
  orgList = [];

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    this.getOrganizationList();
    this.getCriteriaGroupList();
  }

  getOrganizationList(): void {
    this.orgList = [];
    this.addtoParameterList();
    this.appHttpService.get("ScreeningCriteriaOrganizationsDropDown", '').then(res => {
      this.orgList = res;
    });
  }

  getCriteriaGroupList(): void {
    this.criteriaGroupList = [];

    let params = "";
    if (this.model.OrganizationID !== undefined && this.model.OrganizationID !== null) {
      params = "?organizationId=" + this.model.OrganizationID;
    }

    this.appHttpService.get("ScreeningCriteriaGroupsDropdown", params).then(res => {
      this.criteriaGroupList = res;
    });
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  OrganizationIsValid() {
    if (this.model.OrganizationID === undefined || this.model.OrganizationID === null) {
      return false;
    }
    return true;
  }

}
