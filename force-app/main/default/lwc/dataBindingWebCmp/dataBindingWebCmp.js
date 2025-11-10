import { LightningElement } from 'lwc';

export default class MyfirstLwcCmp extends LightningElement {
    empName = 'Rajesh';
    empAge = 30;
    Address = 'Bangalore,Karnataka';
    isShow = false;
    Employees = ['Rajesh', 'Ramesh', 'Rakesh'];
    getAddress() {
        console.log('Hello This');
        alert('Welcome');
        this.address = 'Hyderabad, Telangana';
        this.isShow = true;
        this.Employees.push('Suresh');
    }
    getLiveData(event){
        this.dynamicVar = event.target.value;
    }
}