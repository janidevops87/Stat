import { Component } from '@angular/core';
import { ActivatedRoute } from "@angular/router";

@Component({
  templateUrl: './error.component.html'
})
export class ErrorComponent {
  constructor(private route: ActivatedRoute) {

  }

  ngOnInit(): void {
    const el = document.getElementById('timer') as HTMLElement;
    el.hidden = true;
  }
}
