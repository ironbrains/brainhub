import { Component } from '@angular/core';

@Component({
  selector: 'index',
  template: require('./index.component.html')
})
export class IndexComponent {
  constructor() {
    this.company = "Iron Brains";
  }
};
