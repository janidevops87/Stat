import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsActionableDesignationByStatusModel } from './CustomParamsActionableDesignationByStatusModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsActionableDesignationByStatus.component.html'
})
export class CustomParamsActionableDesignationByStatusComponent implements CustomParamComponent {

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }


  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsActionableDesignationByStatusModel();
  reportFormatList = [{ value: "Standard", label: "Standard Format" }, { value: "Age", label: "Group By Age" }, { value: "Gender", label: "Group By Gender" }, { value: "AgeGender", label: "Group By Age and Gender" }]
  states = [];
  

  ngOnInit() {
    this.model.RegistryState = true;
    this.model.RegistryWeb = true;
    this.model.NewYes = true;
    this.model.YesToYes = true;
    this.model.NoToYes = true;
    this.model.TotalYes = true;
    this.model.YesToNo = true;
    this.model.ReportFormat = "Standard";
    this.setStates();
    
  }

  setStates() {
    this.appHttpService.get("RegistryOwnerStates", "?userOrgId=" + Globals.userOrganizationId + '&displayAllStates=false').then(res => {
      this.states = res;
      this.stateChange();
    });
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  stateChange() {
    for (let i = 0; i < this.states.length; i++) {
      switch (this.states[i].state) {
        case "CO": {
          this.model.Colorado = this.states[i].value;
          break;
        }
        case "WY": {
          this.model.Wyoming = this.states[i].value;
          break;
        }
        case "NV": {
          this.model.Nevada = this.states[i].value;
          break;
        }
        case "HI": {
          this.model.Hawaii = this.states[i].value;
          break;
        }
      }
    };
    this.method.createStateList(this.model);
    this.addtoParameterList();
  }

}
