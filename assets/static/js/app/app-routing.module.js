import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent }            from './app.component';
import { IndexComponent }          from './static-pages/index.component';
import { PageNotFoundComponent }   from './static-pages/page-not-found.component';
import { RegistrationComponent }   from './registration/registration.component';
import { LoginComponent }          from './login/login.component';
import { LoggedInGuard }           from './login/logged-in.guard';

export const appRoutes = [
  { path: '',             component: IndexComponent, canActivate: [LoggedInGuard] },
  { path: 'registration', component: RegistrationComponent, canActivate: [LoggedInGuard] },
  { path: 'login',        component: LoginComponent, canActivate: [LoggedInGuard] },
  { path: '**',           component: PageNotFoundComponent }
];

@NgModule({
  imports: [
    RouterModule.forRoot(appRoutes)
  ],
  exports: [
    RouterModule
  ],
  providers: [
    LoggedInGuard
  ]
})
export class AppRoutingModule { }
