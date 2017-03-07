import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginGuard }              from '../login/login.guard';

import { DashboardComponent }      from './dashboard.component';
import { IndexDashboardComponent } from './index-dashboard.component';
import { UserProfileComponent }    from './users/user-profile.component';
import { ProjectsComponent }       from './projects/projects.component';

const dashboardRoutes = [
  {
    path: 'app',
    canActivate: [LoginGuard],
    component: DashboardComponent,
    children: [
      { path: 'dashboard', component: IndexDashboardComponent },
      { path: 'profile', component: UserProfileComponent },
      { path: 'projects', component: ProjectsComponent }
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
