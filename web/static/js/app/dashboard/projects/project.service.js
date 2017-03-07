import { Injectable }    from '@angular/core';
import { Http, Headers, RequestOptions } from '@angular/http';

import 'rxjs/add/operator/map';

@Injectable()
export class ProjectService {
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
            .get('/api/v1/projects', { headers: headers })
            .map(res => res.json());
  }

  create(project) {
    var headers = new Headers();
    this.setHeaders(headers)
    var creds = JSON.stringify({ project: project });
    return this.http
            .post('/api/v1/projects/', creds, { headers: headers })
            .map(res => res.json());
  }

  setHeaders(headers) {
    headers.append('Content-Type', 'application/json');
    headers.append('Authorization', localStorage.getItem('jwt'));

  }
}
