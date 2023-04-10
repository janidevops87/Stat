import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsMessageEventModel } from './CustomParamsMessageEventModel';
import { CommonMethods } from '../commonMethods';



@Component({
  templateUrl: './customParamsMessageEvent.component.html'
})
export class CustomParamsMessageEventComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsMessageEventModel();

  ngOnInit() {
    this.model.DisplayEventLog = true;
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
