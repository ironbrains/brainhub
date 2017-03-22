import { Injectable }    from '@angular/core';
import { Http, Headers, RequestOptions } from '@angular/http';

import 'rxjs/add/operator/map';

@Injectable()
export class TeamService {
  static get parameters() {
    return [[Http]];
  }

  constructor(http) {
    this.http = http;
  }

  getList() {
    var headers = new Headers();
    this.setHeaders(headers);
    return this.http
            .get('/api/v1/teams', { headers: headers })
            .map(res => res.json());
  }

  show(id) {
    id = (id instanceof Object) ? id.id : id;
    var headers = new Headers();
    this.setHeaders(headers);
    return this.http
            .get('/api/v1/projects/' + id, { headers: headers })
            .map(res => res.json());
  }

  create(team) {
    var headers = new Headers();
    this.setHeaders(headers);
    var creds = JSON.stringify({ team: team });
    return this.http
            .post('/api/v1/teams/', creds, { headers: headers })
            .map(res => res.json());
  }

  edit(id) {
    id = (id instanceof Object) ? id.id : id;
    var headers = new Headers();
    this.setHeaders(headers);
    return this.http
            .get('/api/v1/teams/' + id + '/edit', { headers: headers })
            .map(res => res.json());
  }

  update(team) {
    var headers = new Headers();
    this.setHeaders(headers);
    var creds = JSON.stringify({ team: team });
    return this.http
            .put('/api/v1/teams/' + project.id, creds, { headers: headers })
            .map(res => res.json());
  }

  destroy(id) {
    var headers = new Headers();
    id = (id instanceof Object) ? id.id : id;
    this.setHeaders(headers);
    var creds = JSON.stringify({});
    return this.http
            .delete('/api/v1/teams/' + id, { headers: headers })
            .map(res => res.json());
  }

  setHeaders(headers) {
    headers.append('Content-Type', 'application/json');
    headers.append('Authorization', localStorage.getItem('jwt'));

  }
}
