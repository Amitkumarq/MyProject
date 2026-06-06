import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import CASENUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import ORIGIN_FIELD from '@salesforce/schema/Case.Origin';
import REASON_FIELD from '@salesforce/schema/Case.Reason';
import STATUS_FIELD from '@salesforce/schema/Case.Status';

const FIELDS = [CASENUMBER_FIELD, ORIGIN_FIELD, REASON_FIELD, STATUS_FIELD];

export default class CreateFieldWithoutLightningRecord extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    caseVar;

    get caseNumber() {
        return this.caseVar?.data?.fields?.CaseNumber?.value;
    }
    get origin() {
        return this.caseVar?.data?.fields?.Origin?.value;
    }
    get reason() {
        return this.caseVar?.data?.fields?.Reason?.value;
    }
    get status() {
        return this.caseVar?.data?.fields?.Status?.value;
    }
}
