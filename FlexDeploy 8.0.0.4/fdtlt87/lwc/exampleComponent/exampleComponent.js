import { LightningElement, track, wire } from 'lwc';
import hasAccess from '@salesforce/apex/ProfileCheckController.hasAccess';

export default class ExampleComponent extends LightningElement {
    @track showComponent = false;

    @wire(hasAccess)
    wiredAccess({ error, data }) {
        if (data) {
            this.showComponent = data;
        } else if (error) {
            console.error(error);
        }
    }
}