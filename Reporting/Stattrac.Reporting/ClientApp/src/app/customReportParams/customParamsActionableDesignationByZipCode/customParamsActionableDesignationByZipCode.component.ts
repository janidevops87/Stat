import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsActionableDesignationByZipCodeModel } from './CustomParamsActionableDesignationByZipCodeModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsActionableDesignationByZipCode.component.html'
})
export class CustomParamsActionableDesignationByZipCodeComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsActionableDesignationByZipCodeModel();
  states = [];

  constructor(private appHttpService: AppHttpService, public globals: Globals) {

  }

  ngOnInit() {
    this.model.ZipCodeOptions = "1";
    this.model.RegistryState = true;
    this.model.RegistryWeb = true;
    this.model.NewYes = true;
    this.model.YesToYes = true;
    this.model.NoToYes = true;
    this.model.TotalYes = true;
    this.setStates();
    document.getElementById("TotalYes").setAttribute("disabled", "true");
    this.model.YesToNo = true;
    this.setStates();
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

  setStates() {
    this.appHttpService.get("RegistryOwnerStates", "?userOrgId=" + Globals.userOrganizationId + '&displayAllStates=false').then(res => {
      this.states = res;
      this.stateChange();
    }).then().catch(error => {
      console.log(error);
    });;
  }

  ZipCodeOptionChanged() {
    if (this.model.ZipCodeOptions === "3") {
      document.getElementById("TotalYes").removeAttribute("disabled");
    }
    else {
      document.getElementById("TotalYes").setAttribute("disabled", "true");
    }
    this.addtoParameterList();
  }
}
