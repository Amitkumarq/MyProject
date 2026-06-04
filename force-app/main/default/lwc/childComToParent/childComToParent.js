import { LightningElement } from 'lwc';

export default class ChildComToParent extends LightningElement {
    myName = '';

    handleInputChange() {
        this.myName = 'Amit';
        const myEvent = new CustomEvent('myevent', {
            detail: { name: this.myName, age: 20, city: 'Delhi' }
        });
        this.dispatchEvent(myEvent);
    }
}
