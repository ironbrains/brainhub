import { Component }    from '@angular/core';
import { UserService }  from '../../users/user.service';
import { AlertService } from '../../alerts/alert.service';

@Component({
  selector: 'user-profile',
  template: require('./user-profile.component.html.slim'),
  providers: []
})
export class UserProfileComponent {
  static get parameters() {
    return [[UserService], [AlertService]];
  }

  constructor(userService, alertService) {
    this.userService = userService;
    this.alertService = alertService;
    this.user = userService.currentUser(true);
    this.userService.getCurrentUser().subscribe(
      success => this.user = success,
      error => {
        console.log(error);
      }
    )
  }

  update() {
    this.userService.update(this.user).subscribe(
      success => {
        this.alertService.successMessage('Profile is successfully updated');
        this.user = success;
      },
      error => {
        console.log(error);
      }
    )
  }
};
