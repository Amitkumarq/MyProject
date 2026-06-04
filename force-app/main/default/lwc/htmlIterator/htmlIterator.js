import { LightningElement } from 'lwc';

export default class HtmlIterator extends LightningElement {
    todoItem = [
        { Id: 1, task: 'create task', priority: 'high' },
        { Id: 2, task: 'edit task', priority: 'medium' },
        { Id: 3, task: 'upload task', priority: 'low' }
    ];
}
