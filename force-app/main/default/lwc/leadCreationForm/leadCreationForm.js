import { LightningElement, track } from 'lwc';
import createLead from '@salesforce/apex/LeadHandlerForm.createLead';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LeadLoginForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track company = '';
    @track phone = '';

    handleChange(event) {
        const field = event.target.name;
        this[field] = event.target.value;
    }

    handleSubmit() {
        if (!this.firstName || !this.lastName || !this.email || !this.company) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Missing Fields',
                    message: 'Please fill in all required fields.',
                    variant: 'warning'
                })
            );
            return;
        }

        createLead({
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            company: this.company,
            phone: this.phone
        })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: `Lead created successfully! Id: ${result}`,
                        variant: 'success'
                    })
                );
                this.firstName = '';
                this.lastName = '';
                this.email = '';
                this.company = '';
                this.phone = '';
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}
