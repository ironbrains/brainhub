import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ProjectService } from './project.service'

@Component({
  selector: 'new-project',
  template: require('./new-project.component.html.slim'),
  providers: [ProjectService]
})
export class NewProjectComponent {
  static get parameters() {
    return [[Router], [ProjectService]];
  }

  constructor(router, projectService) {
    this.router = router;
    this.projectService = projectService;
    this.project = {};
  }

  create() {
    this.loading = true;
    this.projectService.create(this.project).subscribe(
      success => {
        this.project = {};
        this.loading = false;
        this.router.navigate(['/app/projects']);
      },
      error => {
        this.loading = false;
      }
    );
  }
};
