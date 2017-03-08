import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ProjectService } from './project.service';

@Component({
  selector: 'show-project',
  template: require('./show.component.html.slim'),
  providers: [ProjectService]
})
export class ShowProjectComponent implements OnInit, OnDestroy {
  static get parameters() {
    return [[Router], [ActivatedRoute], [ProjectService]];
  }

  constructor(router, route, projectService) {
    this.router = router;
    this.route = route;
    this.projectService = projectService;
    this.project = {};
    this.loading = true;
  }

  destroy() {
    this.loading = true;

    this.projectService.destroy(this.id).subscribe(
      success => {
        this.loading = false;
        this.router.navigate(['app/projects']);
      },
      error => {
        console.log(error);
        this.loading = false;
      }
    )
  }

  ngOnInit() {
    this.sub = this.route.params
      .subscribe(params => {
        this.id = +params.id;
        this.projectService.get(this.id).subscribe(
          success => {
            this.project = success;
            this.loading = false;
          },
          error => {
            console.log(error);
            this.loading = false;
          }
        )
      });
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }
};
