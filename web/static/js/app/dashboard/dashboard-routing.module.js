import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginGuard }              from '../login/login.guard';

import { DashboardComponent }      from './dashboard.component';
import { IndexDashboardComponent } from './index-dashboard.component';
import { UserProfileComponent }    from './users/user-profile.component';
import { ProjectsComponent }       from './projects/projects.component';
import { ShowProjectComponent }    from './projects/show.component';
import { EditProjectComponent }    from './projects/edit.component';
import { NewProjectComponent }     from './projects/new.component';

const dashboardRoutes = [
  {
    path: 'app',
    canActivate: [LoginGuard],
    component: DashboardComponent,
    children: [
      { path: 'dashboard', component: IndexDashboardComponent },
      { path: 'profile', component: UserProfileComponent },
      {
        path: 'projects',
        children: [
          { path: '',    component: ProjectsComponent },
          { path: 'new', component: NewProjectComponent },
          { path: ':id/edit', component: EditProjectComponent },
          { path: ':id', component: ShowProjectComponent }
        ]
      }
    ]

  }
];

@NgModule({
  imports: [
    RouterModule.forChild(dashboardRoutes)
  ],
  exports: [
    RouterModule
  ],
  providers: [
    LoginGuard
  ]
})
export class DashboarRoutingModule { }
