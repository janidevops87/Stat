import { Component, ViewChild, OnInit, TemplateRef } from '@angular/core';
import { Router } from '@angular/router';
import { AppHttpService } from './apphttp.Service';
import { ReferralModel } from './model';
import { RecaptchaComponent } from 'ng-recaptcha';
import * as moment from 'moment-timezone';
import { BsModalService, BsModalRef } from 'ngx-bootstrap/modal';

@Component({ templateUrl: './referral.component.html' })
export class ReferralComponent implements OnInit {
  url = 'api/referral';
  model = new ReferralModel();
  validationErrors: any = {};
  showSpinner = false;
  isProcessing = false;
  counter = 0;
  minDate: Date;
  maxDate: Date;
  listVentilator = [];
  listAgeUnit = [];
  listTitle = [];
  listRace = [];
  listWeightUnit = [];
  listSex = [];
  listYesNo = [];
  listYesNoUnknown = [];
  listHospitalUnit = [];
  listTimeZone = [];
  listFacilityCode = [];
  timeZoneAbbr: string;
  observesDaylightSavings: boolean;
  sec = 900;
  secpass: number;
  countDown: number;
  timerValue: string;
  invalidFacilityCode = true;
  facilityCodeErrorMessage = '';
  isTitleDisabled = false;
  cardiacDeathInFuture = false;
  extubationDateInFuture = false;
  admitInFuture = false;
  dobInFuture = false;
  dobDisabled = false;
  isMedicalRecordDuplicate = false;
  isWeightInvalid: boolean = false;
  modalRef: BsModalRef;
  @ViewChild(RecaptchaComponent, { static: false }) recaptchaComponent: RecaptchaComponent;
  @ViewChild('template', { static: false }) modal: TemplateRef<any>;

  constructor(private router: Router, private appHttpService: AppHttpService, private modalService: BsModalService) {
    this.minDate = new Date(1800, 0, 1);
    this.maxDate = new Date(new Date().setFullYear(new Date().getFullYear() + 1)); // Nothing in the future

    // If there is data from a previous save then auto populate some basic information
    if (sessionStorage.getItem("ReferrralModel") != null) {
      let oldModel: ReferralModel = JSON.parse(sessionStorage.getItem("ReferralModel"));
      this.model.facilityEreferralCode = oldModel.facilityEreferralCode;
      this.model.contactFirstName = oldModel.contactFirstName;
      this.model.contactLastName = oldModel.contactLastName;
      this.model.callbackPhoneNumber = oldModel.callbackPhoneNumber;
      this.model.callbackPhoneNumberExtension = oldModel.callbackPhoneNumberExtension;
    }
  }

  ngOnInit(): void {
    let url = window.location.toString().toLowerCase();
    let urlPrefix = "";
    let sourceCode = "";

    if (url.indexOf("scode") < 0) {
      this.router.navigateByUrl('/Error');
      return;
    }
    else {
      this.appHttpService.get(urlPrefix + "api/Server/version", "").then(res => {
        const el = document.getElementById('version') as HTMLElement;
        el.innerHTML = res;
      });
      sourceCode = url.substring(url.indexOf("=") + 1);

      this.appHttpService.get(urlPrefix + "api/Server/GetSourceCodeId", "?sourceCode=" + sourceCode).then(res => {
        if (res === -1) {
          this.router.navigateByUrl('/Error');
          return;
        }
        else {
          this.model.sourceCodeId = res;
        }
      })
    }
    this.listVentilator = [{ value: -1, label: '' }, { value: 0, label: 'Yes, currently' },
    { value: 1, label: 'No, previously' }, { value: 2, label: 'Never' }];
    this.listAgeUnit = [{ value: 1, label: 'Years' }, { value: 2, label: 'Months' },
    { value: 4, label: 'Days' }];
    this.listWeightUnit = [{ value: 1, label: 'kg' }, { value: 2, label: 'g' },
    { value: 3, label: 'lbs' }, { value: 4, label: 'oz' }];
    this.listYesNo = [{ value: -1, label: '' }, { value: 1, label: 'Yes' }, { value: 2, label: 'No' }];
    this.listYesNoUnknown = [{ value: 0, label: '' }, { value: 1, label: 'Yes' }, { value: 2, label: 'No' }, { value: 3, label: 'Unknown' }];
    this.listSex = [{ value: 0, label: '' }, { value: 2, label: 'Female' },
    { value: 1, label: 'Male' }];
    this.appHttpService.get(urlPrefix + "api/List/titles", "").then(res => {
      this.listTitle = res.map(function (x) { return { value: x.contactTitleId, label: x.contactTitleName }; })
    });
    this.appHttpService.get(urlPrefix + "api/List/races", "").then(res => {
      this.listRace = res.map(function (x) { return { value: x.raceId, label: x.raceName }; })
    });
    this.appHttpService.get(urlPrefix + "api/List/hospitalunits", "").then(res => {
      this.listHospitalUnit = res.map(function (x) { return { value: x.hospitalUnitId, label: x.hospitalUnitName }; })
    });
    this.appHttpService.get(urlPrefix + "api/List/facilitycodes", "?sourcecode=" + sourceCode).then(res => {
      this.listFacilityCode = res.map(function (x) { return { value: x.facilityCode, label: x.facilityName }; })
    });

    this.model.weightUnitId = 1;
    this.model.ageUnitId = 1;
    const dis = this;
    this.countDown = window.setInterval(function () {
      dis.countdownTimer();
    }, 1000);
    const el = document.getElementById('timer') as HTMLElement;
    el.hidden = false;

    this.listTimeZone["AT"] = "Atlantic Time (Canada)";
    this.listTimeZone["ET"] = "America/New_York";
    this.listTimeZone["CT"] = "America/Chicago";
    this.listTimeZone["MT"] = "America/Denver";
    this.listTimeZone["AZ"] = "America/Phoenix";
    this.listTimeZone["PT"] = "America/Los_Angeles";
    this.listTimeZone["AK"] = "America/Alaska";
    this.listTimeZone["HT"] = "Pacific/Honolulu";
  }

  openModal(template: TemplateRef<any>) {
    this.modalRef = this.modalService.show(template);
    this.modalService.onHide.subscribe((reason: string) => {
      this.sec = 900;
    });
  }

  stopCalendarPopup(event): boolean {
    if (event.keyCode === 13) {
      event.stopPropagation();
      event.preventDefault();
      event.bubbles = false;
      return false;
    }

    // left arrow, right arrow, escape, backspace, tab, delete
    const navKeys = [37, 39, 27, 8, 9, 46];
    if (navKeys.indexOf(event.keyCode) > -1)
      return true;

    //numbers, backslash
    const keysForDate = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 191];
    //numbers, dot
    const keysForWeight = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 190, 108, 110, 194];

    const keysForAge = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105];
    const val = event.currentTarget.value;

    if (((event.currentTarget.name === "cardiacDeathDate" ||
      event.currentTarget.name === "admitDate" || event.currentTarget.name === "dob" ||
      event.currentTarget.name === "extubationDate") && keysForDate.indexOf(event.keyCode) < 0) ||

      (event.currentTarget.name === "age" && keysForAge.indexOf(event.keyCode) < 0) ||

      (event.currentTarget.name === "weight" && (keysForWeight.indexOf(event.keyCode) < 0 ||
        val.length > 6 || (event.keyCode === 190 && val.indexOf(".") > 0) ||
        (event.keyCode !== 190 && val.indexOf(".") < 0 && val.substring(0).length > 4) ||
        (event.keyCode !== 190 && val.indexOf(".") >= 0 && val.substring(val.indexOf(".")).length > 1)))) {
      event.stopPropagation();
      event.preventDefault();
      return false;
    }
  }

  contactOnChange(): void {
    if (this.invalidFacilityCode ||
      this.model.contactFirstName === null || this.model.contactFirstName === undefined ||
      this.model.contactLastName === null || this.model.contactLastName === undefined)
      return;
    const url = window.location.toString().toLowerCase();
    const code = url.substring(url.indexOf("=") + 1);

    const element = document.getElementById("titleLabel") as HTMLElement;
    element.classList.add("loading");

    this.appHttpService.get("api/Server/facilityinfo", "?sourceCode=" + code +
      "&facilityCode=" + this.model.facilityEreferralCode +
      "&contactFirstName=" + this.model.contactFirstName +
      "&contactLastName=" + this.model.contactLastName).then(res => {
        const obj = JSON.parse(res.value);
        if (obj.contactTitleId != null) {
          this.model.contactTitleId = obj.contactTitleId;
          this.isTitleDisabled = true;
          this.validationErrors["contactTitleId"] = null;
          this.model.organizationId = obj.organizationId;
        }
        else {
          this.isTitleDisabled = false;
        }
        element.classList.remove("loading");
      });
  }

  medicalRecordKeyDown($event): void {
    if ($event.key === "Tab" || $event.key === "Enter")
      return;
    this.isMedicalRecordDuplicate = false;
  }

  medicalRecordOnChange(): void {
    if (this.model.medicalRecordNumber === null || this.model.medicalRecordNumber === undefined || this.model.medicalRecordNumber === '')
      return;
    const mrec = document.getElementById("medicalRecordNumber") as HTMLElement;
    let url = window.location.toString().toLowerCase();
    const code = url.substring(url.indexOf("=") + 1);

    const element = document.getElementById("medicalRecordNumberLabel") as HTMLElement;
    element.classList.add("loading");

    this.appHttpService.get("api/Server/IsMedicalRecordDuplicate", "?sourceCode=" + code +
      "&facilityCode=" + this.model.facilityEreferralCode +
      "&medicalRecord=" + this.model.medicalRecordNumber).then(res => {
        this.isMedicalRecordDuplicate = res;
        console.log('isMedicalRecordDuplicate= ' + res);
        element.classList.remove("loading");
        if (res === false) {
          mrec.classList.remove("is-invalid");
          mrec.classList.add("is-valid");
        }
        else {
          mrec.classList.add("is-invalid");
          mrec.classList.remove("is-valid");
        }

      });
  }

  facilityCodeOnChange(): void {
    if (this.model.facilityEreferralCode === null || this.model.facilityEreferralCode === undefined ||
      this.model.facilityEreferralCode.trim() === '') {
      this.invalidFacilityCode = false;
      return;
    }
    const element = document.getElementById("facilityEreferralCodeLabel") as HTMLElement;
    element.classList.add("loading");

    const url = window.location.toString().toLowerCase();
    const code = url.substring(url.indexOf("=") + 1);

    this.appHttpService.get("api/Server/facilityinfo", "?sourceCode=" + code + "&facilityCode=" + this.model.facilityEreferralCode).then(res => {
      this.invalidFacilityCode = false;
      const obj = JSON.parse(res.value);
      if (obj.facilityCode.indexOf("organization") > 0) {
        this.invalidFacilityCode = true;
        this.facilityCodeErrorMessage = 'Not a Valid Facility E-referral Code.';
      }
      else {
        this.model.referralFacility = obj.facilityName;
        this.timeZoneAbbr = obj.timeZoneAbbr;
        this.model.timeZone = obj.timeZoneAbbr;
        this.model.timeZoneId = obj.timeZoneId;
        this.observesDaylightSavings = obj.observesDaylightSavings;
        this.isExtubationDateInFuture();
        this.model.organizationId = obj.organizationId;

        this.model.contactFirstName = null;
        this.model.contactLastName = null;
        this.model.contactTitleId = null;
        element.classList.remove("loadingInTextBox");

        //const el = document.getElementById('divPatientInfo') as HTMLElement;
        //setTimeout(function () {
        //    el.scrollIntoView({ behavior: "smooth", block: "start", inline: "start" });
        //}, 1000);
      }
      element.classList.remove("loading");
    });
  }

  phoneOnChange(): void {
    let url = window.location.toString().toLowerCase();
    const code = url.substring(url.indexOf("=") + 1);

    const element = document.getElementById("callbackPhoneNumberLabel") as HTMLElement;
    element.classList.add("loading");

    this.appHttpService.get("api/Server/hospitalunitandfloor", "?sourceCode=" + code +
      "&facilityCode=" + this.model.facilityEreferralCode +
      "&phone=" + this.model.callbackPhoneNumber).then(res => {
        if (res.value === '' || res.value === null) {
          this.model.hospitalUnitId = null;
          this.model.floor = null;
        }
        else {
          const obj = JSON.parse(res.value);
          this.model.hospitalUnitId = obj.hospitalUnitId;
          this.model.floor = obj.floor;
        }
        element.classList.remove("loading");
      });
  }

  dobOnChange(): void {
    this.isDobInFuture();
    if (this.model.dob === null || this.dobInFuture)
      return;
    const now = new Date();
    const dob = this.model.dob;
    const diff = Math.round(now.getTime() - dob.getTime());
    const years = now.getFullYear() - dob.getFullYear();
    if (years > 1) {
      this.model.age = years;
      if (Date.parse(now.getFullYear() + '-' + (dob.getMonth() + 1) + '-' + dob.getDate()) > now.getTime())
        this.model.age = years - 1;
      this.model.ageUnitId = 1;
    }
    else {
      let months = years * 12;
      months += now.getMonth();
      months -= dob.getMonth();
      if (months > 0) {
        this.model.age = months;
        this.model.ageUnitId = 2;
      }
      else {
        const days = Math.round(diff / 1000 / 60 / 60 / 24);
        this.model.age = days;
        this.model.ageUnitId = 4;
      }
    }
  }

  ageChange(): void {
    if (this.model.age.toString().trim() !== "") {
      this.dobDisabled = true;
      this.model.dob = null;
    }
    else
      this.dobDisabled = false;
  }

  isExtubationDateInFuture(): void {
    const now = moment().utc().valueOf();
    const element = document.getElementById("extubationDate") as HTMLElement;
    if (this.model.extubationDate === null || this.model.extubationDate === undefined || this.timeZoneAbbr === null || this.timeZoneAbbr === undefined) {
      element.classList.remove("is-valid");
      element.classList.remove("is-invalid");
      this.extubationDateInFuture = false;
      return;
    }
    let time = this.model.extubationTime;
    if (time === null || time === undefined)
      time = '00:00';
    const extDate = moment.tz(moment(this.model.extubationDate).format("YYYY-MM-DD") + " " + time,
      this.listTimeZone[this.timeZoneAbbr]);

    if (now < extDate.valueOf()) {
      this.extubationDateInFuture = true;
      element.classList.remove("is-valid");
      element.classList.add("is-invalid");
    }
    else {
      element.classList.add("is-valid");
      element.classList.remove("is-invalid");
      this.extubationDateInFuture = false;
    }
  }

  isCardiacDeathInFuture(): void {
    const now = moment().utc().valueOf();
    const element = document.getElementById("cardiacDeathDate") as HTMLElement;

    if (this.model.cardiacDeathDate === null) {
      this.cardiacDeathInFuture = false;
      element.classList.remove("is-valid");
      element.classList.remove("is-invalid");
      return;
    }
    let time = this.model.cardiacDeathTime;
    if (time === null || time === undefined)
      time = '00:00';
    const extDate = moment.tz(moment(this.model.cardiacDeathDate).format("YYYY-MM-DD") + " " + time,
      this.listTimeZone[this.timeZoneAbbr])
    if (now < extDate.valueOf()) {
      this.cardiacDeathInFuture = true;
      element.classList.remove("is-valid");
      element.classList.add("is-invalid");
    }
    else {
      element.classList.add("is-valid");
      element.classList.remove("is-invalid");
      this.cardiacDeathInFuture = false;
    }
  }

  isAdmitDateInFuture(): void {
    const now = moment().utc().valueOf();
    const element = document.getElementById("admitDate") as HTMLElement;

    if (this.model.admitDate === null || this.model.admitDate === undefined) {
      this.admitInFuture = false;
      element.classList.remove("is-valid");
      element.classList.remove("is-invalid");
      return;
    }
    let time = this.model.admitTime;
    if (time === null || time === undefined)
      time = '00:00';
    const extDate = moment.tz(moment(this.model.admitDate).format("YYYY-MM-DD") + " " + time,
      this.listTimeZone[this.timeZoneAbbr])
    if (now < extDate.valueOf()) {
      this.admitInFuture = true;
      element.classList.remove("is-valid");
      element.classList.add("is-invalid");
    }
    else {
      element.classList.add("is-valid");
      element.classList.remove("is-invalid");
      this.admitInFuture = false;
    }
  }

  isDobInFuture(): void {
    const now = moment().utc().valueOf();
    const element = document.getElementById("dob") as HTMLElement;

    if (this.model.dob === null) {
      this.dobInFuture = false;
      element.classList.remove("is-valid");
      element.classList.remove("is-invalid");
      return;
    }
    const time = '00:00';
    const extDate = moment.tz(moment(this.model.dob).format("YYYY-MM-DD") + " " + time,
      this.listTimeZone[this.timeZoneAbbr])
    if (now < extDate.valueOf()) {
      this.dobInFuture = true;
      element.classList.remove("is-valid");
      element.classList.add("is-invalid");
    }
    else {
      element.classList.add("is-valid");
      element.classList.remove("is-invalid");
      this.dobInFuture = false;
    }
  }

  hideRequired(control): boolean {
    if (control.touched) {
      if (!control.value || control.value === '') {
        return false;
      }
    }
    return true;
  }

  isValid(control) {
    if (control.touched) {
      if (this.isValidControl(control)) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }

  isValid2(control, alsoThis: boolean) {
    if (control.touched) {
      if (this.isValidControl(control) || alsoThis) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }

  isValid3(control, andThis: boolean) {
    if (control.touched) {
      if (this.isValidControl(control) && andThis) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }

  isValidControl(control): boolean {
    if (control === undefined)
      return true;
    if (control.touched) {
      if (!control.valid) {
        return false;
      }
      else if (this.validationErrors != null && this.validationErrors[control.name] != null) {
        return false;
      }
    }
    return true;
  }

  isValidControl2(control, orThis: boolean): boolean {
    if (control.touched) {
      if (orThis)
        return true;
      if (!control.valid) {
        return false;
      }
      else if (this.validationErrors != null && this.validationErrors[control.name] != null) {
        return false;
      }
    }
    return true;
  }

  isValidPhone(control) {
    if (control.touched) {
      if (this.isValidPhoneControl(control)) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }

  isValidPhoneControl(control): boolean {
    if (control.touched) {
      if (!control.valid) {
        return false;
      }
      else if (control.value.length !== 10) {
        return false;
      }
      else if (this.validationErrors != null && this.validationErrors[control.name] != null) {
        return false;
      }
    }
    return true;
  }

  isValidFacility(control) {
    if (control.touched) {
      if (this.isValidControl(control) && this.invalidFacilityCode === false) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }

  isAgeValid(control, alsoThis: boolean) {
    if (control.touched) {
      if (this.model.ageUnitId === 2 && this.model.age > 120) {
        return { 'is-invalid': true };
      }
      if (this.isValidControl(control) || alsoThis) {
        return { 'is-valid': true };
      }
      return { 'is-invalid': true };
    }
    return {};
  }
  isMonthLessThan120() {
    if (this.model.ageUnitId === 2 && this.model.age > 120) {
      return false;
    }
    return true;
  }
  recaptchaFailed(): boolean {
    return (this.validationErrors !== null && this.validationErrors["recaptchaSecret"] != null) ? false : true;
  }

  clearServerErrors(control): void {
    this.validationErrors[control.name] = null;
  }

  formIsValid(referralForm) {
    //const invalid = [];
    //const controls = referralForm.controls;
    //for (const name in controls) {
    //  if (controls[name].invalid) {
    //    invalid.push(name);
    //  }
    //}
    //console.log(invalid);
    //return (referralForm.valid && this.model.recaptcha != null);
    //return (referralForm.valid && document.querySelectorAll('.radioParent.required').length === 0);
    console.log("formValid:" + referralForm.valid +
      ", radioParent.requiredlength=" + document.querySelectorAll('.radioParent.required').length +
      ", is-invalid.length=" + document.querySelectorAll('.is-invalid').length);

    return (referralForm.valid &&
      document.querySelectorAll('.radioParent.required').length === 0 &&
      document.querySelectorAll('.is-invalid').length === 0);
  }

  captchaResolved(captchaResponse: string) {
    this.model.recaptcha = captchaResponse;
    if (captchaResponse !== '' && this.validationErrors != null) {
      this.validationErrors["recaptchaSecret"] = null;
    }
  }
  countdownTimer(): void {
    let min = Math.floor(this.sec / 60);
    let minStr = min.toString();
    let remSec = this.sec % 60;
    let remSecStr = remSec.toString();
    if (remSec < 10) {
      remSecStr = '0' + remSec;
    }
    if (min < 10) {
      minStr = '0' + min.toString();
    }
    this.timerValue = "Form will time out in " + minStr + ":" + remSecStr;
    if (this.sec > 0) {
      this.sec = this.sec - 1;
    } else {
      clearInterval(this.countDown);
      window.location.reload();
    }
    if (this.sec === 119) {
      this.openModal(this.modal);
    }
    const el = document.getElementById('timer') as HTMLElement;
    el.innerHTML = this.timerValue;
  }
  submit(): void {
    this.isProcessing = true;
    this.showSpinner = true;
    const self = this;
    if (self.model.cardiacDeathDate === undefined)
      self.model.cardiacDeathDateTime = null;
    else {
      const el = document.getElementById('cardiacDeathDate') as HTMLInputElement;
      self.model.cardiacDeathDateTime = new Date(el.value + " " + (self.model.cardiacDeathTime + " UTC" || "00:00 UTC"));

    }
    if (self.model.admitDate === undefined)
      self.model.admitDateTime = null;
    else {
      const el = document.getElementById('admitDate') as HTMLInputElement;
      self.model.admitDateTime = new Date(el.value + " " + (self.model.admitTime + " UTC" || "00:00 UTC "));
    }
    if (self.model.extubationDate === undefined)
      self.model.extubationDateTime = null;
    else {
      const el = document.getElementById('extubationDate') as HTMLInputElement;
      self.model.extubationDateTime = new Date(el.value + " " + (self.model.extubationTime + " UTC" || "00:00 UTC"));
    }

    self.model.weightUnitName = self.listWeightUnit[self.model.weightUnitId - 1].label;
    self.model.ageUnitName = self.listAgeUnit.find(e => e.value === self.model.ageUnitId).label;
    self.model.ventilatorName = self.listVentilator[self.model.ventilatorId + 1].label;
    self.model.sexName = self.listSex.find(x => x.value === self.model.sexId).label;
    if (self.model.raceId !== null && self.model.raceId !== undefined)
      self.model.raceName = self.listRace.find(x => x.value === self.model.raceId).label;
    self.model.age = parseInt(self.model.age.toString());
    if (self.model.ageEstimated !== null && self.model.ageEstimated !== undefined)
      self.model.ageEstimated = self.model.ageEstimated.toString().toLowerCase() === "true" ? "1" : "0";
    if (self.model.weightEstimated !== null && self.model.weightEstimated !== undefined)
      self.model.weightEstimated = self.model.weightEstimated.toString().toLowerCase() === "true" ? "1" : "0";
    if (self.model.identityUnknown !== null && self.model.identityUnknown !== undefined)
      self.model.identityUnknown = self.model.identityUnknown.toString().toLowerCase() === "true" ? "1" : "0";
    this.appHttpService.post("api/Referral", self.model)
      .then(result => {
        clearInterval(this.countDown);
        const el = document.getElementById('timer') as HTMLElement;
        el.hidden = true;
        const ret = JSON.parse(result.toString());
        self.showSpinner = false;
        self.isProcessing = false;
        self.model.recaptcha = null;
        sessionStorage.setItem("ReferralModel", JSON.stringify(self.model));
        self.router.navigateByUrl('/Confirmation?ret=' + ret.RuleOut + "," + ret.CaseId);
      }).catch(msg => {
        self.showSpinner = false;
        self.isProcessing = false;
        self.recaptchaComponent.reset();
      });
  }
}
