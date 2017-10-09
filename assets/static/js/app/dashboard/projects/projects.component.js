import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ProjectService } from './project.service'

@Component({
  selector: 'projects',
  template: require('./projects.component.html.slim'),
  providers: [ProjectService]
})
export class ProjectsComponent {
  static get parameters() {
    return [[Router], [ProjectService]];
  }

  constructor(router, projectService) {
    this.router = router;
    this.projectService = projectService;
    this.loading = true;
    this.getProjects();
  }

  getProjects() {
    this.projectService.getList().subscribe(
      data => {
        this.projects = data.projects;
        this.loading = false;
      },
      error => {
        console.log('error', error);
        this.loading = false;
      }
    )
  }

  redirectTo(project) {
    this.router.navigate(['app/projects', project.id]);
  }
};
