import { Component } from '@angular/core';

@Component({
  selector: 'brainhub',
  template: require('./app.component.html'),
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor() {
    this.company = "Iron Brains";
  }
};