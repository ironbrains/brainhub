import { Component }      from '@angular/core';

@Component({
  selector: 'index-timer',
  template: require('./index.component.html.slim')
})
export class IndexTimerComponent {
  constructor() {
    this.duration = 0;
    this.parseDuration();
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
