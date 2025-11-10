import { LightningElement } from 'lwc';

export default class MyfirstLwcCmp extends LightningElement {
    empName = 'Rajesh';
    empAge = 30;
    Address = 'Bangalore,Karnataka';
    isShow = false;
    getAddress() {
        console.log('Hello This');
        alert('Welcome');
        this.address = 'Hyderabad, Telangana';
        this.isShow = true;
    }
}