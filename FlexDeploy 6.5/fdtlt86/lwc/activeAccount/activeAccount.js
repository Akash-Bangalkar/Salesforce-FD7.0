import { LightningElement, wire } from 'lwc';
import getActiveAccounts from '@salesforce/apex/AccountController.getActiveAccounts';

export default class ActiveAccount extends LightningElement {
    // Change 1.0
    // Change 2.0
    // Change 6.5
    @wire(getActiveAccounts)
    accounts;
}