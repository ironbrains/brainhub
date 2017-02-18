import { Component }   from '@angular/core';
import { Router }      from '@angular/router';
import { UserService } from '../users/user.service';

@Component({
  selector: 'registration-form',
  template: require('./registration-form.component.html.slim'),
  providers: []
})

export class RegistrationFormComponent {
  static get parameters() {
    return [[UserService], [Router]];
  }

  constructor(userService, router) {
    this.user = {};
    this.userService = userService;
    this.router = router;
  }

  submit() {
    this.loadingStart();

    this.userService.registration(this.user).subscribe(
      status => {
        this.loadingStop();
        this.router.navigate(['/dashboard']);
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