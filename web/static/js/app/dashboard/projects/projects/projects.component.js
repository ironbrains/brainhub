import { Component } from '@angular/core';
import { ProjectService } from './project.service'

@Component({
  selector: 'projects',
  template: require('./projects.component.html.slim'),
  providers: [ProjectService]
})
export class ProjectsComponent {
  static get parameters() {
    return [[ProjectService]];
  }

  constructor(projectService) {
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
};
