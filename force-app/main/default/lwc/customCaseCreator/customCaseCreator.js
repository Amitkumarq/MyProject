import { LightningElement, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

import CASE_OBJECT from '@salesforce/schema/Case';
import SUBJECT from '@salesforce/schema/Case.Subject';
import PRIORITY from '@salesforce/schema/Case.Priority';
import DESCRIPTION from '@salesforce/schema/Case.Description';
import RECORDID from '@salesforce/schema/Case.RecordTypeId';

export default class CustomCaseCreator extends LightningElement {
    subject = '';
    priority = '';
    description = '';
    recordTypeId = '';

    // record type Id
    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
    caseInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
            console.log('Default Record Type Id:', this.recordTypeId);
        } else {
            console.log('Something went wrong', error);
        }
    }

    get options() {
        return [
            { label: 'Low', value: 'low' },
            { label: 'Medium', value: 'medium' },
            { label: 'High', value: 'high' }
        ];
    }

    populateSubject(e) {
        this.subject = e.target.value;
    }

    populatePriority(e) {
        this.priority = e.target.value;
    }

    populateDescription(e) {
        this.description = e.target.value;
    }

    async createCase() {
        const fields = {};
        // Map the user input to the fields
        fields[SUBJECT.fieldApiName] = this.subject;
        fields[PRIORITY.fieldApiName] = this.priority;
        fields[DESCRIPTION.fieldApiName] = this.description;
        fields[RECORDID.fieldApiName] = this.recordTypeId;

        // Configure your recordInput object with the object and field API names
        const recordInput = { apiName: CASE_OBJECT.objectApiName, fields };

        try {
            // Invoke createRecord
            const caseRec = await createRecord(recordInput);
            console.log('case has been created' + JSON.stringify(caseRec));
        } catch (error) {
            // Handle error
            console.log(
                'Something went wrong during case creation' + error.body.message
            );
        }
    }
}
