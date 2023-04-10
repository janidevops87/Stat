import { Component, OnInit, OnDestroy, ViewChild, TemplateRef, HostListener } from '@angular/core';
import { BsModalService, BsModalRef } from 'ngx-bootstrap/modal';
import { Router, ActivatedRoute } from '@angular/router';
import { Globals } from '../globals.Service';
import { CookieService } from 'ngx-cookie-service';

@Component({
  selector: 'app-logoutmodal',
  templateUrl: './logoutmodal.component.html'
})
export class LogoutModalComponent implements OnDestroy, OnInit {
  public counter: number = 0;
  public parent: string;
  public timerValue: string;
  public returnUrl: string;
  public message = '';
  public seconds: number;
  public startSeconds: number;
  public showModalSeconds: number = 0;

  modalRef2: BsModalRef;
  @ViewChild('autoLogOut', { static: false }) modal2: TemplateRef<any>;

  constructor(private route: ActivatedRoute, private router: Router,
    private modalService2: BsModalService, public globals: Globals,
    private cookieService: CookieService) {
  }

  @HostListener('document:mouseup', ['$event'])
  onMouseDown(event) {
    this.resetTimer();
  }

  @HostListener('document:keydown', ['$event'])
  onKeyDown(event) {
    this.resetTimer();
  }

  resetTimer() {
    this.seconds = this.startSeconds;
  }

  ngOnDestroy() {
    console.log('destroy-' + this.parent);
    this.clearTimer();
    this.seconds = undefined;
    this.startSeconds = undefined;
    this.parent = undefined;
  }

  ngOnInit(): void {
    this.clearTimer();
  }

  startTimer() {
    console.log('startTimer-' + this.parent);

    this.seconds = this.startSeconds;
    const dis = this;
    this.counter = window.setInterval(function () {
      dis.countDown();
    }, 1000);
    //console.log('start-' + this.counter);
  }

  private countDown() {
    if (this.seconds % 30 == 0)
      console.log(this.parent + '-' + this.seconds);
    if (this.router.url.split('?')[0] == '/')
      return;
    let min = Math.floor(this.seconds / 60);
    let minStr = min.toString();
    let remSec = this.seconds % 60;
    let remSecStr = remSec.toString();
    if (remSec < 10) {
      remSecStr = '0' + remSec;
    }
    if (min < 10) {
      minStr = '0' + min.toString();
    }
    this.timerValue = "You will be logged out due to inactivity in " + minStr + ":" + remSecStr;
    if (this.seconds > 0) {
      this.seconds = this.seconds - 1;
    } else {
      this.clearTimer();
      let dis = this;
      setTimeout(function () {
        console.log('Navigate-' + dis.parent);
        dis.clearTimer();
        dis.modalService2.hide();
        dis.ngOnDestroy();
        dis.router.navigateByUrl('/?message=You have been auto logged out due to inactivity.');
      }, 1000);
    }
    if (this.seconds === this.showModalSeconds) {
      console.log('openModal-' + this.parent);
      this.openModal2(this.modal2);
    }
  }

  private clearTimer() {
    window.clearInterval(this.counter);
  }

  openModal2(template: TemplateRef<any>) {
    this.modalRef2 = this.modalService2.show(template, { id: 2, class: 'modal-dialog-centered', animated: true });
    let dis = this;
    this.modalService2.onHide.subscribe((reason: string) => {
      if (dis.router.url.split('?')[0] != '/') {
        dis.seconds = dis.startSeconds;
        this.globals.checkAuth(); //to reset the session timeout on the server
      }
      else
        dis.clearTimer();
    });
  }
}

