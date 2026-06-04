import { LightningElement } from 'lwc';

export default class ParentCommToChild extends LightningElement {
    childObj = {};

    handleEvent(event) {
        const { name, age, city } = event.detail;
        this.childObj = { name, age, city };
    }
}
