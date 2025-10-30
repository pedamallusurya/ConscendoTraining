import { LightningElement, wire,track } from 'lwc';
import getAccounts from '@salesforce/apex/sampleApexforCommunication.getAccounts';
import getContacts from '@salesforce/apex/sampleApexforCommunication.getContacts';

export default class ClientToServerCommunication extends LightningElement {
    listofaccounts;
    @wire(getContacts) contacts;

    @wire(getAccounts)
    accountsFunction({ data, error}) {
        if (data) {
            this.listofaccounts = data;
        } else if (error) {
         console.error(error);
        }
    }
}