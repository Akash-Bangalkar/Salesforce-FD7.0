import { LightningElement, wire } from 'lwc';
import getActiveAccounts from '@salesforce/apex/AccountController.getActiveAccounts';

export default class ActiveAccount extends LightningElement {
    @wire(getActiveAccounts)
    accounts;
}