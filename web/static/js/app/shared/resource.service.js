import { Injectable }    from '@angular/core';
import { Http, Headers, RequestOptions } from '@angular/http';

@Injectable()
export class ResourceService {
  static get parameters() {
    return [[Http]];
  }

  constructor(http) {
    this.http = http;
  }

  setHeaders(headers) {
    headers.append('Content-Type', 'application/json');
    headers.append('Authorization', localStorage.getItem('jwt'));
  }
}
