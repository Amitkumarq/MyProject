import { LightningElement } from 'lwc';

export default class LoadRecord extends LightningElement {
    recordId = '500gL00000v3J5JQAU';
    objectApiName = 'Case';
    fields = ['CaseNumber', 'Priority', 'Status'];
}
