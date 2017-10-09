import { Component }   from '@angular/core';
import { Router }      from '@angular/router';
import { UserService } from '../users/user.service';

@Component({
  selector: 'navbar',
  template: require('./navbar.component.html.slim')
})
export class NavbarComponent {
  static get parameters() {
    return [[UserService], [Router]];
  }

  constructor(userService, router) {
    this.userService = userService;
    this.router = router;
    this.user = userService.currentUser();
  }

  logout() {
    console.log('logout');
    this.userService.logout();
    this.router.navigate(['/']);
  }
};