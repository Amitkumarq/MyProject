import { LightningElement,api } from 'lwc';

export default class WelcomePage extends LightningElement {
    // parent component @api myFavTeam defining here 
    @api myFavTeam = 'KKR';
}