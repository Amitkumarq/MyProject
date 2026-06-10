import { LightningElement, wire } from 'lwc';
import getCasesInSequence from '@salesforce/apex/CaseController.getCasesInSequence';

export default class CreateCaseListUsingWire extends LightningElement {
    caseList;
    errorMsg;
    //stringValue;

    // wire without parameter
    @wire(getCasesInSequence)
    wiredMethod({ data, error }) {
        if (data) {
            this.caseList = data;
            this.errorMsg = '';
        } else {
            this.caseList = undefined;
            this.errorMsg = error?.body?.message;
        }
    }

    // wire with parameter
    // @wire(getCasesInSequence, { stringKey: '$stringValue' })
    // wireMethod({ data, error }) {
    //     if (data) {
    //         this.caseList = data;
    //         this.errorMsg = '';
    //     } else {
    //         this.caseList = undefined;
    //         this.errorMsg = error?.body?.message;
    //     }
    // }
}
