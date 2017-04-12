import { Component }      from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location }       from '@angular/common';

import { TeamService } from './team.service';
import { UserService } from '../../users/user.service'

@Component({
  selector: 'show-team',
  template: require('./show.component.html.slim'),
  providers: [TeamService]
})
export class ShowTeamComponent implements OnInit, OnDestroy {
  static get parameters() {
    return [[ActivatedRoute], [TeamService], [UserService], [Location]];
  }

  constructor(route, teamService, userService, location) {
    this.route = route;
    this.teamService = teamService;
    this.userService = userService;
    this.location = location;
    this.team = {};
    this.loading = true;
  }

  destroy() {
    this.loading = true;
  }

  ngOnInit() {
    this.userService.index().subscribe(
      success => {
        this.users = success.users.map(user => {
          return { value: user.id, label: `${user.first_name} ${user.last_name}` };
        });
      }
    )

    this.sub = this.route.params
      .subscribe(params => {
        this.id = +params.id;
        this.teamService.show(this.id).subscribe(
          success => {
            this.team = success;
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
    return true;
  }

  showMemberForm() {
    this.memberAdding = true;
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  addMember() {
    console.log(this.newMember);
    this.newMemberId = null;
  }
};
