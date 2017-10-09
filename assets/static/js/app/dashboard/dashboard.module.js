import 'zone.js';

import { NgModule }      from '@angular/core';
import { FormsModule }   from '@angular/forms'
import { HttpModule }    from '@angular/http'
import { CommonModule }  from '@angular/common';
import { SelectModule }  from 'ng-select';
import { ReactiveFormsModule } from '@angular/forms';

import { DashboarRoutingModule }   from './dashboard-routing.module';

import { NavbarComponent }         from '../shared/navbar.component';

import { DashboardComponent }      from './dashboard.component';

import { IndexTimerComponent }     from './timer/index.component';
import { TimerProjectsListComponent } from './timer/projects-list.component';
import { IndexDashboardComponent } from './index-dashboard.component';
import { UserProfileComponent }    from './users/user-profile.component';

import { ProjectsComponent }       from './projects/projects.component';
import { ShowProjectComponent }    from './projects/show.component';
import { EditProjectComponent }    from './projects/edit.component';
import { NewProjectComponent }     from './projects/new.component';
import { ProjectForm }             from './projects/form.component';

import { ShowTeamComponent }       from './teams/show.component';

import { UserService }             from '../users/user.service';

@NgModule({
  declarations: [
    DashboardComponent,
    IndexTimerComponent,
    TimerProjectsListComponent,
    IndexDashboardComponent,
    UserProfileComponent,

    ProjectsComponent,
    ShowProjectComponent,
    EditProjectComponent,
    NewProjectComponent,
    ProjectForm,

    ShowTeamComponent,

    NavbarComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    SelectModule,
    DashboarRoutingModule
  ],
  providers: [
    UserService
  ],
})
export class DashboardModule { }
