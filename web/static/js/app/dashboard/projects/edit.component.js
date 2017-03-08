import { Component } from '@angular/core';
import { ProjectService } from './project.service'
import { ShowProjectComponent } from './show.component'

@Component({
  selector: 'edit-project',
  template: require('./edit.component.html.slim'),
  providers: [ProjectService]
})
export class EditProjectComponent extends ShowProjectComponent {

  constructor(router, route, projectService) {
    super(router, route, projectService);
  }

  update() {
    this.loading = true;
    this.projectService.update(this.project).subscribe(
      success => {
        this.project = success;
        this.loading = false;
        this.router.navigate(['app/projects', this.project.id]);
      },
      error => {
        this.loading = false;
      }
    );
  }
};
