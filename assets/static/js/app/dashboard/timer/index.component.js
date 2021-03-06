import { Component } from '@angular/core';
import { TimerService } from './timer.service';

@Component({
  selector: 'index-timer',
  template: require('./index.component.html.slim'),
  providers: [TimerService]
})
export class IndexTimerComponent {
  static get parameters() {
    return [[TimerService]];
  }

  constructor(timerService) {
    this.timerService = timerService;
    this.project = {}
    this.duration = 0;
    this.parseDuration();

    this.timerService.getList().subscribe(
      success => {
        console.log('success', success);
      },
      error => {
        console.log(error);
      }
    )
  }

  toggle() {
    this.isActive = !this.isActive;
    if (this.isActive) {
      this.interval = setInterval(() => {
        this.duration++;
        this.parseDuration();
      }, 1000);
    } else {
      clearInterval(this.interval);
    }
  }

  selectProject() {
    this.showProjectsList = true;
  }

  parseDuration() {
    let sec_num = this.duration;
    let hours   = Math.floor(sec_num / 3600);
    let minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    let seconds = sec_num - (hours * 3600) - (minutes * 60);

    if (hours   < 10) { hours   = "0" + hours; }
    if (minutes < 10) { minutes = "0" + minutes; }
    if (seconds < 10) { seconds = "0" + seconds; }

    this.durationString = `${hours}:${minutes}:${seconds}`;
  }
};
