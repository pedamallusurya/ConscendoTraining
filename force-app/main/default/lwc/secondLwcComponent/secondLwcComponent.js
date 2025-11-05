import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/SampleApexforCommunication.getAccounts';
import updateAccounts from '@salesforce/apex/SampleApexforCommunication.updateAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Rating', fieldName: 'Rating', editable: true },
    { label: 'Phone', fieldName: 'Phone', editable: true }
];

export default class SecondLwcComponent extends LightningElement {
    @track accounts;
    @track draftValues = [];
    columnsList = columns;

    // Fetch accounts
    fetchAllSmbCustomers() {
        getAccounts()
            .then(result => {
                this.accounts = result;
                console.log('Accounts fetched:', result);
            })
            .catch(error => {
                console.error('Error fetching accounts:', error);
            });
    }
     handleRowAction(event) {
        const actionName = event.detail.action.name;
        const recordId = event.detail.row.Id;

        if (actionName === 'view_record') {
            this.navigateToRecord(recordId);
        }
    }

    // Save edited records
    handleSave(event) {
        const updatedFields = event.detail.draftValues;
        console.log('Saving updates:', updatedFields);

        updateAccounts({ updatedAccList: updatedFields })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records updated successfully!',
                        variant: 'success'
                    })
                );

                // Clear draft values
                this.draftValues = [];

                // Refresh table
                return this.fetchAllSmbCustomers();
            })
            .catch(error => {
                console.error('Error updating:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating records',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    newCustomers() {
        // You can navigate to new record creation here
        console.log('New Customer button clicked');
    }
}
