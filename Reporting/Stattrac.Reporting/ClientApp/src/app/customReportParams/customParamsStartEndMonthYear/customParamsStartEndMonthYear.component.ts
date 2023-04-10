import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsStartEndMonthYearModel } from './CustomParamsStartEndMonthYearModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';



@Component({
  templateUrl: './customParamsStartEndMonthYear.component.html'
})
export class CustomParamsStartEndMonthYearComponent implements CustomParamComponent {
  constructor(private appHttpService: AppHttpService) {
    this.getYearDropDown();
    this.getMonthDropDown();
    //set default to current month and year
    const currentDate = new Date();
    this.model.EndMonth = currentDate.getMonth() + 1;
    this.model.StartMonth = currentDate.getMonth() +1;
    this.model.EndYear = currentDate.getFullYear();
    this.model.StartYear = currentDate.getFullYear();
    
    
  }

  ngOnInit() {
    this.addtoParameterList();
  }

  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsStartEndMonthYearModel();
  monthList = [];
  yearList = [];

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

  getYearDropDown(): void {

    this.appHttpService.get("YearDropdown", "").then(res => {
      this.yearList = res;
    });
  }

  getMonthDropDown(): void {

    this.appHttpService.get("MonthDropdown", "").then(res => {
      this.monthList = res;
    });
  }

}
