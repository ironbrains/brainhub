import { Injectable }    from '@angular/core';
import { Http, Headers } from '@angular/http';

import 'rxjs/add/operator/map';

@Injectable()
export class UserService {
  static get parameters() {
    return [[Http]];
  }

  constructor(http) {
    this.http = http;
  }

  registration(user) {
    var headers = new Headers();
    headers.append('Content-Type', 'application/json');
    var creds = JSON.stringify({
      user: {
        first_name: user.firstName,
        last_name: user.lastName,
        email: user.email,
        password: user.password,
        password_confirmation: user.passwordConfimation
      }
    })
    return this.http
            .post('/api/v1/registrations/', creds, { headers })
            .map(res => res.json())
            .map(res => {
                localStorage.setItem('user', JSON.stringify(res.user));
                localStorage.setItem('jwt', res.jwt);
                true
            });
  }

  currentUser() {
    return JSON.parse(localStorage.user)
  }
}