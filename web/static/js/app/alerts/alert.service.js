import { Injectable, EventEmitter } from '@angular/core';

@Injectable()
export class AlertService {
  constructor() {
    this.alertEvent = new EventEmitter()
  }

  showAlert(alert) {
    this.alertEvent.emit(alert);
  }

  successMessage(message) {
    this.showAlert({
      class: 'alert-success',
      message: message
    });
  }

  errorMessage(message) {
    this.showAlert({
      class: 'alert-danger',
      message: message
    });
  }
}
