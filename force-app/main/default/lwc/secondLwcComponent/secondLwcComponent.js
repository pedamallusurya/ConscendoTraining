import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/sampleApexforCommunication.getAccounts';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' }
];

export default class SecondLwcComponent extends LightningElement {
    accounts;
    columnsList = columns;

    fetchAllSmbCustomers(event) {
        getAccounts()
            .then(result => {
                this.accounts = result;
                // eslint-disable-next-line no-console
                console.log(result);
            })
            .catch(error => {
                // eslint-disable-next-line no-console
                console.error(error);
            });
    }
    newCustomers(event){
          
    }
}
