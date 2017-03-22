import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ProjectService } from './project.service';
import { TeamService } from '../teams/team.service';
import { Location } from '@angular/common';

@Component({
  selector: 'show-project',
  template: require('./show.component.html.slim'),
  providers: [ProjectService, TeamService]
})
export class ShowProjectComponent implements OnInit, OnDestroy {
  static get parameters() {
    return [[Router], [ActivatedRoute], [ProjectService], [TeamService], [Location]];
  }

  constructor(router, route, projectService, teamService, location, gettingMethod = 'show') {
    this.router = router;
    this.route = route;
    this.projectService = projectService;
    this.teamService = teamService;
    this.location = location;
    this.project = {};
    this.newTeam = {};
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

  showTeamForm() {
    this.newTeam = { project_id: this.id }
    this.teamCreating = true;
  }

  createTeam() {
    console.log(this.newTeam);
    this.loading = true;
    this.teamService.create(this.newTeam).subscribe(
      success => {
        this.project.teams.push(success);
        this.loading = false;
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
