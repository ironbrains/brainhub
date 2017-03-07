import 'zone.js';

import { NgModule }      from '@angular/core';
import { FormsModule }   from '@angular/forms'
import { HttpModule }    from '@angular/http'
import { CommonModule }  from '@angular/common';

import { DashboarRoutingModule }     from './dashboard-routing.module';

import { NavbarComponent }           from '../shared/navbar.component'

import { DashboardComponent }        from './dashboard.component';
import { IndexDashboardComponent }   from './index-dashboard.component';
import { UserProfileComponent }      from './users/user-profile.component';
import { ProjectsComponent }         from './projects/projects.component';
import { ProjectForm }               from './projects/form.component';

import { UserService }               from '../users/user.service'

@NgModule({
  declarations: [
    DashboardComponent,
    IndexDashboardComponent,
    UserProfileComponent,
    ProjectsComponent,
    ProjectForm,

    NavbarComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    DashboarRoutingModule
  ],
  providers: [
    UserService
  ],
})
export class DashboardModule { }
