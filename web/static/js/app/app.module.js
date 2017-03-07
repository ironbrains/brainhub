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

import { DashboardModule }        from './dashboard/dashboard.module';

import { UserService }               from './users/user.service'

@NgModule({
  declarations: [
    AppComponent,
    IndexComponent,
    PageNotFoundComponent,
    RegistrationComponent,
    RegistrationFormComponent,
    LoginComponent,
    LoginFormComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    DashboardModule,
    AppRoutingModule
  ],
  providers: [
    UserService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
