import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent }           from './app.component';
import { IndexComponent }         from './static-pages/index.component';
import { PageNotFoundComponent }  from './static-pages/page-not-found.component';
import { RegistrationComponent }  from './registration/registration.component';
import { LoginComponent }         from './login/login.component';
import { LoginGuard }             from './login/login.guard'
import { LoggedInGuard }          from './login/logged-in.guard'

import { DashboardComponent }     from './dashboard/dashboard.component'
import { IndexDashboardComponent } from './dashboard/index-dashboard.component'
import { UserProfileComponent }   from './dashboard/users/user-profile.component'

export const appRoutes = [
  { path: '',             component: IndexComponent, canActivate: [LoggedInGuard] },
  { path: 'registration', component: RegistrationComponent, canActivate: [LoggedInGuard] },
  { path: 'login',        component: LoginComponent, canActivate: [LoggedInGuard] },
  {
    path: 'app',
    canActivate: [LoginGuard],
    component: DashboardComponent,
    children: [
      { path: 'dashboard', component: IndexDashboardComponent },
      { path: 'profile', component: UserProfileComponent }
    ]
    
  },
  {
    path: '**',
    component: PageNotFoundComponent
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(
      appRoutes
    )
  ],
  exports: [
    RouterModule
  ],
  providers: [
    LoginGuard,
    LoggedInGuard
  ]
})
export class AppRoutingModule { }