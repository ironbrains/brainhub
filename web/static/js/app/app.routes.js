import { RouterModule, Routes } from '@angular/router';

import { AppComponent }          from './app.component';
import { IndexComponent }        from './static-pages/index.component';
import { RegistrationComponent } from './registration/registration.component';

export const routes = [
  { path: '',             component: IndexComponent },
  { path: 'registration', component: RegistrationComponent },
  { path: '**',           component: RegistrationComponent }
];