import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsProcessorModel } from './CustomParamsProcessorModel';
import { CommonMethods } from '../commonMethods';



@Component({
  templateUrl: './customParamsProcessor.component.html'
})
export class CustomParamsProcessorComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsProcessorModel();
  processorList = [{ value: "CTDN", label: "CTDN" }, { value: "Cryolife", label: "Cryolife" }, { value: "MTF", label: "MTF" }, { value: "LifeNet", label: "LifeNet" }];

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
