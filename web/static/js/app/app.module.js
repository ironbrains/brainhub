import 'zone.js';

import { BrowserModule } from '@angular/platform-browser';
import { NgModule }      from '@angular/core';
import { FormsModule }   from '@angular/forms'
import { HttpModule }    from '@angular/http';
import { RouterModule }  from '@angular/router';

import { AppComponent }              from './app.component';
import { IndexComponent }            from './static-pages/index.component';
import { RegistrationComponent }     from './registration/registration.component';
import { RegistrationFormComponent } from './registration/registration-form.component';
import { LoginComponent }            from './login/login.component';
import { LoginFormComponent }        from './login/login-form.component';
import { UserProfileComponent }      from './users/user-profile.component';
import { UserService }               from './users/user.service'
import { LoginGuard }                from './login/login.guard'
import { LoggedInGuard }             from './login/logged-in.guard'

import { routes } from './app.routes'

@NgModule({
  declarations: [
    AppComponent,
    IndexComponent,
    RegistrationComponent,
    RegistrationFormComponent,
    LoginComponent,
    LoginFormComponent,
    UserProfileComponent
  ],
  imports: [
    RouterModule.forRoot(routes),
    BrowserModule,
    FormsModule,
    HttpModule
  ],
  providers: [
    UserService,
    LoginGuard,
    LoggedInGuard
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }