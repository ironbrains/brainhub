import { Component }     from '@angular/core';
import { SignUpService } from './sign-up.service';

@Component({
  selector: 'sign-up',
  template: require('./sign-up.component.html.slim'),
  providers: [SignUpService]
})

export class SignUpComponent {
  static get parameters() {
    return [[SignUpService]];
  }

  constructor(signUpService) {
    this.user = {};
    this.signUpService = signUpService;
  }

  submit() {
    this.signUpService.submit(this.user).subscribe(
      user => {
        localStorage.setItem('user', JSON.stringify(user.user));
        localStorage.setItem('jwt', user.jwt);
      },
      error => console.log('error', error)
    );
  }
};