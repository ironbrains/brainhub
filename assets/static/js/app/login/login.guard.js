import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';
import { UserService } from '../users/user.service';

@Injectable()
export class LoginGuard implements CanActivate {
  static get parameters() {
    return [[UserService], [Router]];
  }

  constructor(userService, router) {
    this.userService = userService;
    this.router = router;
  }

  canActivate() {
    if (!this.userService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return false;
    }
    return true;
  }
}