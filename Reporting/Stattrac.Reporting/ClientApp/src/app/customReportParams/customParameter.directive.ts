
import { Directive, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[customParameterSection]'
})
export class CustomParameterDirective {
  constructor(public viewContainerRef: ViewContainerRef) { }
}
