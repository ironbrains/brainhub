import { RouterModule, Routes } from '@angular/router';

import { AppComponent }          from './app.component';
import { IndexComponent }        from './static-pages/index.component';
import { RegistrationComponent } from './registration/registration.component';
import { LoginComponent }        from './login/login.component';
import { UserProfileComponent }  from './users/user-profile.component';
import { LoginGuard }            from './login/login.guard'
import { LoggedInGuard }         from './login/logged-in.guard'

export const routes = [
  { path: '',             component: IndexComponent, canActivate: [LoggedInGuard] },
  { path: 'registration', component: RegistrationComponent, canActivate: [LoggedInGuard] },
  { path: 'login',        component: LoginComponent, canActivate: [LoggedInGuard] },
  { path: 'profile',      component: UserProfileComponent, canActivate: [LoginGuard] },
  { path: '**',           component: RegistrationComponent }
];