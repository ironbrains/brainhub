import { Component }     from '@angular/core';
import { Router }        from '@angular/router';
import { UserService } from '../users/user.service';

@Component({
  selector: 'login-form',
  template: require('./login-form.component.html.slim'),
  providers: []
})

export class LoginFormComponent {
  static get parameters() {
    return [[UserService], [Router]];
  }

  constructor(userService, router) {
    this.user = {};
    this.userService = userService;
    this.router = router;
    if (this.userService.isLoggedIn()) {
      this.router.navigate(['']);
    }
  }

  submit() {
    this.loadingStart();

    this.userService.login(this.user).subscribe(
      status => {
        this.loadingStop();
      },
      error => {
        console.log('error', error);
        this.loadingStop();
      }
    );
  }

  loadingStart() {
    this.loading = true;
  }

  loadingStop() {
    this.loading = false;
  }
};