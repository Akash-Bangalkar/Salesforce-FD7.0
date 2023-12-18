// FlexDeploy MetadataList LWC - JS
import { LightningElement, track, wire } from 'lwc';
import getUserNames from '@salesforce/apex/FDMetadataXml.getUserNames';
import getMetadataList from '@salesforce/apex/FDMetadataXml.getMetadataList';

export default class FDMetadataList extends LightningElement {
    @track selectedTimeRange = 'Last 1 Day';
    @track selectedUser = null;
    @track data = null;
    @track userOptions = [];

    timeRangeOptions = [
        { label: 'Last 1 Day', value: 'Last 1 Day' },
        { label: 'Last 2 Days', value: 'Last 2 Days' },
        { label: 'Last 1 Week', value: 'Last 1 Week' },
        { label: 'Last 1 Month', value: 'Last 1 Month' },
        { label: 'Last 6 Months', value: 'Last 6 Months' },
        { label: 'Last 1 Year', value: 'Last 1 Year' },
        { label: 'All Time', value: 'All Time' },
    ];

    @wire(getUserNames)
    userNames({ error, data }) {
        if (data) {
            this.userOptions = [
                ...data.map(user => ({ label: user, value: user })),
                { label: 'All Users', value: null }
            ];

            // Set the default user (if the list is not empty)
            if (this.userOptions.length > 0) {
                this.selectedUser = this.userOptions[0].value;
            }
        } else if (error) {
            console.error('Error fetching user names', error);
        }
    }

    handleTimeRangeChange(event) {
        this.selectedTimeRange = event.detail.value;
    }

    handleUserChange(event) {
        this.selectedUser = event.detail.value;
    }

    fetchData() {
        getMetadataList({ timeRange: this.selectedTimeRange, selectedUser: this.selectedUser })
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.error('Error fetching metadata list', error);
            });
    }

    get columns() {
        return [
            { label: 'File Type', fieldName: 'Section', type: 'text' },
            { label: 'Action', fieldName: 'Action', type: 'text' },
            { label: 'Modified By', fieldName: 'ModifiedBy', type: 'text' },
            { label: 'Modified Date', fieldName: 'FormattedDate', type: 'datetime' },
        ];
    }
}