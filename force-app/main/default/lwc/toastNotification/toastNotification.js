import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/AccountCreationImperative.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastNotification extends LightningElement {
    accountName;

    handleName(event) {
        this.accountName = event.target.value;
        console.log(this.accountName);
    }

    async handleAccountCreation() {
        try {
            const response = await createAccount({
                accountName: this.accountName
            });
            console.log('response:>>> ', response);
            if (response) {
                this.showToast(
                    'success!',
                    'your record has been created succesfully...',
                    'Success'
                );
            } else {
                this.showToast(
                    'failure!',
                    'something went wrong in creating account',
                    'error'
                );
            }
        } catch (error) {
            console.log('catch is running....', error.body.message);
        }
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}
