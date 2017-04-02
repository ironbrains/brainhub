import { Component }   from '@angular/core';
import { AlertService } from './alert.service';

@Component({
  selector: 'alerts',
  template: require('./alerts.component.html.slim')
})
export class AlertsComponent {
  static get parameters() {
    return [[AlertService]];
  }

  constructor(alertService) {
    this.alertService = alertService;
    this.alertsList = [];
    this.currentId = 1;
    this.alertService.alertEvent.subscribe(
      (alert) => {
        alert.id = this.currentId++;
        this.alertsList.push(alert);
        alert.timeout = setTimeout(() => this.close(alert), 5000);
      })
  }

  close(alert) {
    let index = this.alertsList.indexOf(alert);
    clearTimeout(alert.timeout);
    this.alertsList.splice(index, 1);
  }
};
