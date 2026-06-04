import { LightningElement, api } from 'lwc';

export default class ContainerComponent extends LightningElement {
    @api productsFound;
    @api productList;
    parentCalled = false;

    get hasProducts() {
        return this.productsFound === 'true' ? true : false;
    }

    @api handleParentCall() {
        this.parentCalled = true;
    }
}
