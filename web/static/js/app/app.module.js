import 'zone.js';

import { BrowserModule } from '@angular/platform-browser';
import { NgModule }      from '@angular/core';
import { FormsModule }   from '@angular/forms'
import { HttpModule }    from '@angular/http';
import { RouterModule }  from '@angular/router';

import { AppComponent }          from './app.component';
import { IndexComponent }        from './static-pages/index.component';
import { RegistrationComponent } from './registration/registration.component';

import { routes } from './app.routes'

@NgModule({
  declarations: [
    AppComponent,
    IndexComponent,
    RegistrationComponent
  ],
  imports: [
    RouterModule.forRoot(routes),
    BrowserModule,
    FormsModule,
    HttpModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }