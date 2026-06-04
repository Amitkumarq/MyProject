import { LightningElement, api } from 'lwc';

export default class OwnerComponent extends LightningElement {
    @api productsFound = 'true';
    @api productList = [
        {
            id: 1,
            name: 'macbook air',
            price: 8500
        },
        {
            id: 2,
            name: 'macbook pro',
            price: 10000
        },
        {
            id: 3,
            name: 'Dell Alienware',
            price: 9000
        }
    ];

    @api callChildMethod() {
        console.log('parent method called the child method');
        this.template.querySelector('c-container-component').handleParentCall();
    }
}
