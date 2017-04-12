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

                return res
            });
  }

  login(user) {
    var headers = new Headers();
    headers.append('Content-Type', 'application/json');
    var creds = JSON.stringify({ session: user })
    return this.http
            .post('/api/v1/sessions/', creds, { headers })
            .map(res => res.json())
            .map(res => {
                localStorage.setItem('user', JSON.stringify(res.user));
                localStorage.setItem('jwt', res.jwt);

                return res
            });
  }

  logout() {
    localStorage.removeItem('jwt');
    localStorage.removeItem('user');
  }

  isLoggedIn() {
    return !!localStorage.getItem('jwt');
  }

  currentUser() {
    return JSON.parse(localStorage.user)
  }

  getCurrentUser() {
    return this.show(this.currentUser().id).map(res => {
      localStorage.setItem('user', JSON.stringify(res));
      return res;
    });

  }

  index() {
    var headers = new Headers();
    this.setHeaders(headers);
    return this.http
            .get('/api/v1/users', { headers: headers })
            .map(res => res.json());
  }

  show(id) {
    id = (id instanceof Object) ? id.id : id;
    var headers = new Headers();
    this.setHeaders(headers);
    return this.http
            .get('/api/v1/users/' + id, { headers: headers })
            .map(res => res.json());
  }

  update(user) {
    var headers = new Headers();
    this.setHeaders(headers);
    var creds = JSON.stringify({ user: user });
    return this.http
            .put('/api/v1/users/' + user.id, creds, { headers: headers })
            .map(res => res.json());
  }

  setHeaders(headers) {
    headers.append('Content-Type', 'application/json');
    headers.append('Authorization', localStorage.getItem('jwt'));
  }
}
