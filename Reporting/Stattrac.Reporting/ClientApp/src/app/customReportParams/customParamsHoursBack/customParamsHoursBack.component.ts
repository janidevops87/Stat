import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsHoursBackModel } from './CustomParamsHoursBackModel';
import { CommonMethods } from '../commonMethods';



@Component({
  templateUrl: './customParamsHoursBack.component.html'
})
export class CustomParamsHoursBackComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsHoursBackModel();

  ngOnInit() {
    this.model.hoursBack = 3;
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
