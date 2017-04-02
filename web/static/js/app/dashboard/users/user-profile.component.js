import { Component }   from '@angular/core';
import { UserService } from '../../users/user.service';

@Component({
  selector: 'user-profile',
  template: require('./user-profile.component.html.slim'),
  providers: []
})
export class UserProfileComponent {
  static get parameters() {
    return [[UserService]];
  }

  constructor(userService) {
    this.userService = userService;
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
        this.user = success;
      },
      error => {
        console.log(error);
      }
    )
  }
};
