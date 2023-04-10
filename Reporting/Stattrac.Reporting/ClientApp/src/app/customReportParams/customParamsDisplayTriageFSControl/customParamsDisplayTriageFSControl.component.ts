import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsDisplayTriageFSControlModel } from './CustomParamsDisplayTriageFSControlModel';
import { CommonMethods } from "../commonMethods"



@Component({
  templateUrl: './customParamsDisplayTriageFSControl.component.html'
})
export class CustomParamsDisplayTriageFSControlComponent implements CustomParamComponent {
  @Input() data: any;
  model = new CustomParamsDisplayTriageFSControlModel();
  methods = new CommonMethods();

  ngOnInit() {
    this.model.DisplayFamilyServices = true;
    this.model.DisplayTriage = true;
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.methods.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
