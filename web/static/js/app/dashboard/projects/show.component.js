import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ProjectService } from './project.service';
import { Location } from '@angular/common';

@Component({
  selector: 'show-project',
  template: require('./show.component.html.slim'),
  providers: [ProjectService]
})
export class ShowProjectComponent implements OnInit, OnDestroy {
  static get parameters() {
    return [[Router], [ActivatedRoute], [ProjectService], [Location]];
  }

  constructor(router, route, projectService, location, gettingMethod = 'show') {
    this.router = router;
    this.route = route;
    this.projectService = projectService;
    this.location = location;
    this.project = {};
    this.loading = true;
    this.gettingMethod = gettingMethod;
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
        this.projectService[this.gettingMethod](this.id).subscribe(
          success => {
            this.project = success;
            this.loading = false;
          },
          error => {
            console.log(error);
            this.loading = false;
            this.location.back();
          }
        )
      });
  }

  isEditable() {
    return this.project.creator_id == JSON.parse(localStorage.getItem('user')).id
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }
};
