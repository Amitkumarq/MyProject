import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    userName;
    age;

    _calAge = this.age;

    get calculatedAge() {
        return this._calAge;
    }

    set calculatedAge(value) {
        this._calAge = value < 1000 ? value : 5000;
    }

    handleAge(e) {
        this.calculatedAge = e.target.value;
        console.log(e.target.value);
    }

    handleChange(e) {
        this.userName = e.target.value;
        console.log(e.target.value);
    }
}
