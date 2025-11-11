import { LightningElement } from 'lwc';

export default class DetailForm1 extends LightningElement {
    firstName = '';
    lastName = '';
    email = '';
    phone = '';

    handleChange(event) {
        const { name, value } = event.target;
        if (name === 'FirstName') this.firstName = value;
        else if (name === 'LastName') this.lastName = value;
        else if (name === 'Email') this.email = value;
        else if (name === 'Phone') this.phone = value;
    }

    handleSubmit() {
        console.log('First Name:', this.firstName);
        console.log('Last Name:', this.lastName);
        console.log('Email:', this.email);
        console.log('Phone:', this.phone);
    }
     handleHover() {
        this.Submit =
            '--slds-c-button-brand-color-background: green;' +
            '--slds-c-button-brand-color-border: green;';
    }

    handleMouseOut() {
        this.buttonSSubmittyle =
            '--slds-c-button-brand-color-background: #0176d3;' +
            '--slds-c-button-brand-color-border: #0176d3;';
    }
}
