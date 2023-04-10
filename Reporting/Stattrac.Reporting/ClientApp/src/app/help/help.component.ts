import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Title } from '@angular/platform-browser';
import { AppHttpService } from '../apphttp.Service';
import { Globals } from '../globals.Service';

@Component({
  selector: 'app-help',
  templateUrl: './help.component.html'
})
export class HelpComponent {

  constructor(public router: Router, private appHttpService: AppHttpService,
    private route: ActivatedRoute, private titleService: Title, public globals: Globals) {

  }

  ngOnInit(): void {
    this.globals.checkAuth();
    this.titleService.setTitle("Help - Statline Access Portal");
  }
}
