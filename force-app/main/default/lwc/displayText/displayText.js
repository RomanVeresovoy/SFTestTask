import {LightningElement, wire} from 'lwc';

import sortStrings from '@salesforce/apex/DisplayTextController.sortStrings';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const TEXT =
    'Wlazł kotek na płotek\n' +
    'i mruga,\n' +
    'ładna to piosenka,\n' +
    'nie długa.\n' +
    'Nie długa, nie krótka,\n' +
    'lecz w sam raz,\n' +
    'zaśpiewaj koteczku,\n' +
    'jeszcze raz.';
    
export default class DisplayText extends LightningElement {
    stringsSortedInApex = [];
    stringsSortedInJS = [];
    text = TEXT

    @wire(sortStrings, { text: '$text' })
    wiredText({data, error}) {
        if (data) {
            this.stringsSortedInApex = data;
        } else if (error) {
            this.showToast(result.error.statusText, result.error.body.message, 'error');
        }
    }

    connectedCallback() {
        this.stringsSortedInJS = this.sortStringsByLength(this.text);
    }

    sortStringsByLength(text) {
        let strings = text.split('\n');

        return strings.sort((a, b) => {
            return b.length - a.length;
        });
    }

    showToast(title, message, variant) {
        const showToastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });

        this.dispatchEvent(showToastEvent);
    }
}