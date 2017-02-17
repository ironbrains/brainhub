import { Component }   from '@angular/core';
import { UserService } from '../users/user.service';

@Component({
  selector: 'registration-form',
  template: require('./registration-form.component.html.slim'),
  providers: []
})

export class RegistrationFormComponent {
  static get parameters() {
    return [[UserService]];
  }

  constructor(userService) {
    this.user = {};
    this.userService = userService;
  }

  submit() {
    this.loadingStart();

    this.userService.registration(this.user).subscribe(
      status => this.loadingStop(),
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