import { Injectable }    from '@angular/core';
import { Http, Headers } from '@angular/http';

import 'rxjs/add/operator/map';

@Injectable()
export class SignUpService {
  static get parameters() {
    return [[Http]];
  }

  constructor(http) {
    this.http = http;
    this.name = 'SignUpService';
  }

  submit(user) {
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
    return this.http.post('/api/v1/registrations/', creds, { headers })
            .map(res => res.json());
  }
}