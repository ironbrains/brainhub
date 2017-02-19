import { Component }   from '@angular/core';
import { UserService } from '../users/user.service';

@Component({
  selector: 'index-dashboard',
  template: require('./index-dashboard.component.html.slim'),
  providers: []
})
export class IndexDashboardComponent {
  static get parameters() {
    return [[UserService]];
  }

  constructor(userService) {
    this.userService = userService;
    this.user = userService.currentUser();
  }
};