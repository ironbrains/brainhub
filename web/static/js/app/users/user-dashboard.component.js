import { Component }   from '@angular/core';
import { UserService } from '../users/user.service';

@Component({
  selector: 'user-dashboard',
  template: require('./user-dashboard.component.html.slim'),
  providers: []
})
export class UserDashboardComponent {
  static get parameters() {
    return [[UserService]];
  }

  constructor(userService) {
    this.userService = userService;
    this.user = userService.currentUser();
  }
};