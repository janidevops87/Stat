import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsScheduleLookupModel } from './CustomParamsScheduleLookupModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsScheduleLookup.component.html'
})
export class CustomParamsScheduleLookupComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsScheduleLookupModel();
  scheduleOrganizationList = [];
  scheduleGroupList = [];

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    this.getScheduleOrganization();
    this.getScheduleGroups();
  }

  getScheduleOrganization(): void {
    const params = "?OrganizationId=" + Globals.userOrganizationId;
    this.scheduleOrganizationList = [];
    this.addtoParameterList();
    this.appHttpService.get("ScheduleOrganizationsDropdown", params).then(res => {
      this.scheduleOrganizationList = res;
    });
  }

  getScheduleGroups(): void {
    this.scheduleGroupList = [];
    this.model.ScheduleGroup = null;
    let org = Globals.userOrganizationId;
    if (this.model.ScheduleOrganization !== undefined && this.model.ScheduleOrganization !== null) {
      org = this.model.ScheduleOrganization;
    }
    const params = "?OrganizationId=" + org;
    
    this.appHttpService.get("ScheduleGroupsDropdown", params).then(res => {
      this.scheduleGroupList = res;
    });
  }

  OrganizationChanged() {
    this.getScheduleGroups();
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
