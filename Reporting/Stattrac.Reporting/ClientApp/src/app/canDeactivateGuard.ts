import { Injectable } from "@angular/core";
import { SchedulingComponent } from "./scheduling/scheduling.component";
import { CanDeactivate } from "@angular/router";
import { Globals } from "./globals.Service";

@Injectable()
export class CanDeactivateGuard implements CanDeactivate<SchedulingComponent> {
  canDeactivate(component: SchedulingComponent): boolean {
    //seconds=undefined => auto logout timer starts with a 10 seconds delay, during that time
    //seconds variable is undefined
    if (component.dataChanged && (component.logOutModalComponent.seconds == undefined ||
      component.logOutModalComponent.seconds > 0)) {
      if (confirm("You have unsaved changes! If you leave, your changes will be lost.")) {
        return true;
      } else {
        component.logOutModalComponent.ngOnDestroy();
        component.logOutModalComponent.startSeconds = Globals.AutoLogOut;
        component.logOutModalComponent.showModalSeconds = Globals.AutoLogOutWarning;
        component.logOutModalComponent.parent = "Schedules";
        component.logOutModalComponent.returnUrl = component.router.url;
        component.logOutModalComponent.startTimer();
        return false;
      }
    }
    return true;
  }
}
