import { Component } from '@angular/core';
import { ProjectService } from './project.service'

@Component({
  selector: 'project-form',
  template: require('./form.component.html.slim'),
  providers: [ProjectService]
})
export class ProjectForm {
  static get parameters() {
    return [[ProjectService]];
  }

  constructor(projectService) {
    this.project = {};
    this.projectService = projectService;
  }

  submit() {
    this.loading = true;
    this.projectService.create(this.project).subscribe(
      data => {
        this.project = {};
        this.loading = false;
      },
      error => {
        console.log(error);
        this.loading = false;
      }
    )
  }
};
