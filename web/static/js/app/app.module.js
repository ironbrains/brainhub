import 'zone.js';

import { BrowserModule } from '@angular/platform-browser';
import { NgModule }      from '@angular/core';
import { FormsModule }   from '@angular/forms'
import { HttpModule }    from '@angular/http';

import { AppComponent }              from './app.component';
import { AppRoutingModule }          from './app-routing.module';

import { IndexComponent }            from './static-pages/index.component';
import { PageNotFoundComponent }     from './static-pages/page-not-found.component';
import { RegistrationComponent }     from './registration/registration.component';
import { RegistrationFormComponent } from './registration/registration-form.component';
import { LoginComponent }            from './login/login.component';
import { LoginFormComponent }        from './login/login-form.component';
import { NavbarComponent }           from './shared/navbar.component'

import { DashboardComponent }        from './dashboard/dashboard.component';
import { IndexDashboardComponent }   from './dashboard/index-dashboard.component';
import { UserProfileComponent }      from './dashboard/users/user-profile.component';

import { UserService }               from './users/user.service'
import { LoginGuard }                from './login/login.guard'
import { LoggedInGuard }             from './login/logged-in.guard'

@NgModule({
  declarations: [
    AppComponent,
    IndexComponent,
    PageNotFoundComponent,
    RegistrationComponent,
    RegistrationFormComponent,
    LoginComponent,
    LoginFormComponent,

    DashboardComponent,
    IndexDashboardComponent,
    UserProfileComponent,

    NavbarComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule
  ],
  providers: [
    UserService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }