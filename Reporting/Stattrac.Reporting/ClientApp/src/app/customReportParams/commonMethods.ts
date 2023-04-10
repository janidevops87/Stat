import { Type } from '@angular/core';

export class CommonMethods {
  constructor() { }

  addtoParameterList(model: any) {

    //const params: string[] = [];
    let params = "";
    let delim = "";
    for (const key of Object.keys(model)) {
      const value = model[key];

      if (value !== undefined && value !== null) {
        
        if (typeof value === "object") {
          params += delim  + key + '=' + value.toLocaleDateString("en-US") + " " + value.toLocaleTimeString('en-US');
        }
        else {
          params += delim + key + '=' + value ;
        }
        delim = "|";
      }
    }
    return params;
  }

  customPopulateFieldForCustomComponenents(model: any, hiddenControl: any) {
    const params = this.addtoParameterList(model);
    hiddenControl.setAttribute('value', params);
  }

  createStateList(model: any) {
    let stateString = '';
    let parse = '';
    if (model.Colorado) {
      stateString = 'CO';
      parse = ','
    }
    if (model.Hawaii) {
      stateString += parse + 'HI'
      parse = ','
    }
    if (model.Nevada) {
      stateString += parse + 'NV'
      parse = ','
    }
    if (model.Wyoming) {
      stateString += parse + 'WY'
      parse = ','
    }
    if (stateString.length > 0) {
      model.State = stateString;
    }
    else {
      model.State = null;
    }
  }
}

