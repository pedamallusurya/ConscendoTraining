import { LightningElement } from 'lwc';
import doCreateAccount from '@salesforce/apex/accountCreationValidateForm.doCreateAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import BillingAddress from '@salesforce/schema/Account.BillingAddress';

export default class AccountForm extends LightningElement {
    accountName = '';
    accountNumber = '';
    billingAddress = '';
    // Discrete billing fields to capture City/State/Country/PostalCode
    billingCity = '';
    billingState = '';
    billingCountry = '';
    billingPostalCode = '';
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
    handleBillingCityChange(event){
        this.billingCity = event.target.value;
    }
    handleBillingStateChange(event){
        this.billingState = event.target.value;
    }
    handleBillingCountryChange(event){
        this.billingCountry = event.target.value;
    }
    handleBillingPostalCodeChange(event){
        this.billingPostalCode = event.target.value;
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
        // Build a single params object matching Apex signature exactly
        const params = {
            acntName: this.accountName,
            acntNum: this.accountNumber,
            acntDesc: this.description,
            // Use free-text billingAddress as street if present; also support discrete fields if you add them in HTML
            acntStreet: this.billingAddress || '',
            acntCity: this.billingCity || '',
            acntState: this.billingState || '',
            acntCountry: this.billingCountry || '',
            acntPostalCode: this.billingPostalCode || ''
        };

        doCreateAccount(params)
            .then((result) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created successfully!',
                        variant: 'success'
                    })
                );
                this.resetForm();
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error?.body?.message || 'Error while creating Account',
                        variant: 'error'
                    })
                );
            });
    }
    resetForm() {
        this.accountName = '';
        this.accountNumber = '';
        this.billingAddress = '';
        this.billingCity = '';
        this.billingState = '';
        this.billingCountry = '';
        this.billingPostalCode = '';
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
