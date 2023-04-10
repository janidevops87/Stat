import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsActionableDesignationByEventModel } from './CustomParamsActionableDesignationByEventModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsActionableDesignationByEvent.component.html'
})
export class CustomParamsActionableDesignationByEventComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsActionableDesignationByEventModel();
  mainCategoryList = [];
  subCategoryList = [];
  states = [];
  reportFormatList = [{ value: "Standard", label: "Standard Format" }, { value: "Age", label: "Group By Age" }, { value: "Gender", label: "Group By Gender" }, { value: "AgeGender", label: "Group By Age and Gender" }]

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    //this.model.State = "CO";
    this.model.ReportFormat = "Standard";
    this.model.NewYes = true;
    this.model.YesToYes = true;
    this.model.NoToYes = true;
    this.model.TotalYes = true;
    this.model.YesToNo = true;
    this.setStates();
    this.mainCategorySelect();
    this.subCategorySelect();
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  mainCategorySelect() {
    this.mainCategoryList = [];
    this.appHttpService.get("EventMainCategoryDropDownList", "?state=" + this.model.State).then(res => {
      this.mainCategoryList = res;
    });
  }

  setStates() {
    this.appHttpService.get("RegistryOwnerStates", "?userOrgId=" + Globals.userOrganizationId + '&displayAllStates=false').then(res => {
      this.states = res;
      //set to first one
      this.model.State = this.states[0].state;
      this.addtoParameterList();
    });
  }

  mainCategoryChanged() {
    this.model.SubCategoryID = null;
    this.subCategorySelect();
    this.addtoParameterList();
  }

  subCategorySelect() {
    this.subCategoryList = [];
    this.appHttpService.get("EventSubCategoryDropDownList", "?eventCategoryId=" + this.model.MainCategoryID + "&state=" + this.model.State).then(res => {
      this.subCategoryList = res;
    });
  }

  stateChanged() {
    this.model.MainCategoryID = null;
    this.model.SubCategoryID = null;
    this.mainCategorySelect();
    this.subCategorySelect();
    this.addtoParameterList();
  }

}
