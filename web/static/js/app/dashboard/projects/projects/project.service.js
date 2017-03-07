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
    headers.append('Content-Type', 'application/json');
    return this.http
            .get('/api/v1/projects', {headers: headers})
            .map(res => res.json());
  }
}
