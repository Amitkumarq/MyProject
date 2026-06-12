import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
//import fetchTaskForAccount from '@salesforce/apex/dependentWireController.fetchTaskForAccount';

export default class DependentWires extends LightningElement {
    @api recordId;
    accountName;
    taskList;
    taskFound = false;
    fields = [ACCOUNT_NAME];
    errorMsg;

    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME] })
    wiredAccount({ data, error }) {
        if (Error) {
            console.log('hello test>>');

            console.log(JSON.stringify(data));
            this.accountName = data.fields.Name.value;
            this.errorMsg = undefined;
        } else {
            console.log(
                'something went wrong in fetching account details',
                (this.errorMsg = error?.body?.message)
            );
        }
    }

    // @wire(fetchTaskForAccount, { accountName: '$accountName' })
    // wiredTask({ data, error }) {
    //     if (data) {
    //         this.taskList = data;
    //         this.taskFound = true;
    //         console.log(JSON.stringify(data));
    //         this.errorMsg = undefined;
    //     } else if (error) {
    //         console.log(
    //             'Something went wrong in fetching wiredTask details  ',
    //             (this.errorMsg = error?.body?.message)
    //         );
    //     }
    // }
}
