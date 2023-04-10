import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsImportEventLogModel } from './CustomParamsImportEventLogModel';
import { CommonMethods } from '../commonMethods';



@Component({
  templateUrl: './customParamsImportEventLog.component.html'
})
export class CustomParamsImportEventLogComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsImportEventLogModel();

  ngOnInit() {
    this.model.DisplayEventLog = true;
    this.addtoParameterList();
  }


  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
