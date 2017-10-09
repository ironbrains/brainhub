import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'timer-projects-list',
  template: require('./projects-list.component.html.slim')
})
export class TimerProjectsListComponent {
  @Input() shown;
  @Output() shownChange = new EventEmitter();

  @Input() project;
  @Output() projectChange = new EventEmitter();
  constructor() {
    this.projects = [
      { name: 'First project' },
      { name: 'Second Project' },
      { name: 'Third project' }
    ]
  }

  close() {
    this.shown = false;
    this.shownChange.emit(this.shown);
  }

  select(project) {
    this.project = project;
    this.projectChange.emit(project);
    this.close();
  }
};
