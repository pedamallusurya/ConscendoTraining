import { LightningElement } from 'lwc';
import insertOrUpdateAccount from '@salesforce/apex/accountCreationValidateForm.insertOrUpdateAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountForm extends LightningElement {
    accountName = '';
    accountNumber = '';
    billingAddress = '';
    description = '';

    handleNameChange(event) {
        this.accountName = event.target.value;
    }
    handleNumberChange(event) {
        this.accountNumber = event.target.value;
    }
    handleBillingChange(event){
        this.billingAddress = event.target.value;
    }
    handleDesChange(event){
        this.description = event.target.value;
    }
    handleSubmit() {
        // 🔹 Validation 1: Account Name (min 4, max 15)
        if (!this.accountName || this.accountName.length < 4 || this.accountName.length > 15) {
            this.showToast('Error', 'Account Name must be between 4 and 15 characters.', 'error');
            return;
        }
        // 🔹 Validation 2: Account Number (max 5 digits)
        if (this.accountNumber && this.accountNumber.length > 5) {
            this.showToast('Error', 'Account Number cannot exceed 5 digits.', 'error');
            return;
        }
        const accountRecord = {
            Name: this.accountName,
            AccountNumber: this.accountNumber,
            BillingStreet: this.billingAddress,
            Description: this.description
        };
        // Call Apex Method
        insertOrUpdateAccount({ acc: accountRecord })
            .then(() => {
                this.showToast('Success', 'Account saved successfully!', 'success');
                this.resetForm();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
    resetForm() {
        this.accountName = '';
        this.accountNumber = '';
        this.billingAddress = '';
        this.description = '';
    }
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}
