import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from "@angular/router";

@Component({
  templateUrl: './confirmation.component.html',
})
export class ConfirmationComponent implements OnInit {
  confirmationMessage = '';
  constructor(private route: ActivatedRoute) {
  }
  ngOnInit(): void {
    const ret = this.route.snapshot.queryParamMap.get("ret");
    const data = ret.split(',');
    if (data[0] === 'RO') {
      this.confirmationMessage = `<p>Thank you for submitting an electronic referral.</p>

      <p>This patient has been ruled-out for donation potential and the case is now closed.<br>
      You will not be receiving a follow-up call for this referral.<br>
      For your records, the referral number is:<b>`+ data[1] + `</b></p>

      <p>No further action is required from you.</p>`;
    }
    else {
      this.confirmationMessage = `<p>Thank you for submitting an electronic referral.</p>

      <p>This patient is showing potential for donation at this time.<br>
      A coordinator will call you back using the callback number provided to perform further screening.</p>

      </p>For your records, the referral number is:<b>`+ data[1] +'</b></p>';

    }
  }
}
