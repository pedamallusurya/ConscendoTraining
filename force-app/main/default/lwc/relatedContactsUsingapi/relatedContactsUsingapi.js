import { LightningElement,api,wire} from 'lwc';
import getcontactapi from '@salesforce/apex/sampleApexforCommunication.getcontactapi';
export default class RelatedContactsUsingapi extends LightningElement {
      @api recordId;   
      relatedcontacts;
      @wire(getcontactapi,{accid:'$recordId'} )
         wiredData({data,error}) {
                if(data) this.relatedcontacts=data;
                if(error) console.log(error);
}
}