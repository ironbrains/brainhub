import { Injectable } from '@angular/core';
import { Http, Headers, RequestOptions } from '@angular/http';
import { ResourceService } from '../../shared/resource.service';

import 'rxjs/add/operator/map';

@Injectable()
export class TimerService extends ResourceService {
  constructor(http) {
    super(http);
  }

  getList() {
    var headers = new Headers();
    this.setHeaders(headers);
    return this.http
            .get('/api/v1/time_entries', { headers: headers })
            .map(res => res.json());
  }
}
