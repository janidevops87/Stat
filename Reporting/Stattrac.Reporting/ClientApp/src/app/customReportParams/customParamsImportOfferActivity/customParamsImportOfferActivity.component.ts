import { Component, Input } from '@angular/core';
import { CustomParamComponent } from '../customParam.component';
import { CustomParamsImportOfferActivityModel } from './CustomParamsImportOfferActivityModel';
import { CommonMethods } from '../commonMethods';
import { AppHttpService } from '../../apphttp.Service';
import { ParameterPopupComponent } from '../../parameter-popup/parameter-popup.component';
import { Globals } from '../../globals.Service';



@Component({
  templateUrl: './customParamsImportOfferActivity.component.html'
})
export class CustomParamsImportOfferActivityComponent implements CustomParamComponent {
  @Input() data: any;
  method = new CommonMethods();
  model = new CustomParamsImportOfferActivityModel();
  messageForOrganizationList = [];
  messageForList = [];
  sourceCodeName: string;
  subscription: any;

  constructor(private appHttpService: AppHttpService, private pc: ParameterPopupComponent, public globals: Globals) {

  }
  ngOnInit() {
    this.subscription = this.pc.getsourceCodeChangeEmitter().subscribe(item => this.selectedSourceCode(item));
    this.getMessageForOrganization();
    this.getMessageFor();
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }
  selectedSourceCode(item: string) {
    this.sourceCodeName = item;
    this.getMessageForOrganization();
  }

  getMessageForOrganization(): void {
    let params = "?sourceCodeTypeId=2";

    if (this.sourceCodeName !== undefined && this.sourceCodeName !== null) {
      params += "&sourceCodeName=" + this.sourceCodeName;
    }
    params += "&organizationId=" + Globals.userOrganizationId;
    this.model.MessageForOrganizationID = null;
    this.model.MessageFor = null;
    this.messageForOrganizationList = [];
    this.addtoParameterList();
    this.appHttpService.get("MessageImportOrganizationsDropDown", params).then(res => {
      this.messageForOrganizationList = res;
    });
  }

  getMessageFor(): void {
    this.messageForList = [];
    this.model.MessageFor = null;
    this.addtoParameterList();
    let params = "";
    if (this.model.MessageForOrganizationID !== undefined && this.model.MessageForOrganizationID !== null) {
      params = "?organizationId=" + this.model.MessageForOrganizationID;
    }
    else {
      params = "?organizationId=" + Globals.userOrganizationId;
    }
    this.appHttpService.get("PersonListByOrganizationDropDown", params).then(res => {
      this.messageForList = res;
    });
  }

  changeOrganization() {
    this.getMessageFor();
    this.addtoParameterList();
  }

  addtoParameterList() {
    this.method.customPopulateFieldForCustomComponenents(this.model, document.getElementById("customParameterList"));
  }

}
