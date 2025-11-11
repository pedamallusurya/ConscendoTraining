import { LightningElement, track } from 'lwc';
import insertAccount from '@salesforce/apex/accountCreationValidateForm.insertAccount';
import updateAccount from '@salesforce/apex/accountCreationValidateForm.updateAccount';

export default class AccountForm extends LightningElement {
    @track recordId;
    @track name = '';
    @track accountNumber = '';
    @track billingAddress = '';
    @track description = '';
    @track message = '';

    // Handle input changes
    handleChange(event) {
        const { name, value } = event.target;
        if (name === 'Name') this.name = value;
        if (name === 'AccountNumber') this.accountNumber = value;
        if (name === 'BillingAddress') this.billingAddress = value;
        if (name === 'Description') this.description = value;
    }

    // Validation for Name and Account Number
    validateInputs() {
        if (this.name.length < 4 || this.name.length > 15) {
            this.message = 'Account Name must be between 4 and 15 characters.';
            return false;
        }

        if (this.accountNumber && this.accountNumber.length > 5) {
            this.message = 'Account Number cannot exceed 5 digits.';
            return false;
        }

        return true;
    }

    // Insert Account
    async handleSubmit() {
        if (!this.validateInputs()) return;

        const acc = {
            Id: this.recordId,
            Name: this.name,
            AccountNumber: this.accountNumber,
            BillingStreet: this.billingAddress,
            Description: this.description
        };

        try {
            const result = await insertAccount({ acc });
            this.message = result;
           // this.clearFields();
        } catch (error) {
            this.message = 'Error: ' + error.body.message;
        }
    }

    // Update Account
    async handleUpdate() {
        if (!this.validateInputs()) return;

        const acc = {
            Id: this.recordId,
            Name: this.name,
            AccountNumber: this.accountNumber,
            BillingStreet: this.billingAddress,
            Description: this.description
        };

        try {
            const result = await updateAccount({ acc });
            this.message = result;
        } catch (error) {
            this.message = 'Error: ' + error.body.message;
        }
    }

    clearFields() {
        this.recordId = '';
        this.name = '';
        this.accountNumber = '';
        this.billingAddress = '';
        this.description = '';
    }
}
