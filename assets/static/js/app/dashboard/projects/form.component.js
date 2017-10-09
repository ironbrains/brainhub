import { Component, Input, Output } from '@angular/core';

@Component({
  selector: 'project-form',
  template: require('./form.component.html.slim')
})
export class ProjectForm {
  @Input() project = {};
  @Output() project;
};
