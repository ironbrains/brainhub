import { Component }   from '@angular/core';
import { UserService } from '../users/user.service';

@Component({
  selector: 'navbar',
  template: require('./navbar.component.html.slim')
})
export class NavbarComponent {
  static get parameters() {
    return [[UserService]];
  }

  constructor(userService) {
    this.userService = userService;
    this.user = userService.currentUser();
  }
};