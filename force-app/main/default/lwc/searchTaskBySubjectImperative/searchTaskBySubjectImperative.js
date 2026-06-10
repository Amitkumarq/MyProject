import { LightningElement } from 'lwc';
import fetchTaskBySubject from '@salesforce/apex/taskController.fetchTaskBySubject';

export default class SearchTaskBySubjectImperative extends LightningElement {
    subject;
    taskList;
    errorMessage;

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    async searchTask() {
        try {
            const result = await fetchTaskBySubject({
                subjectString: this.subject
            });
            this.taskList = result;
        } catch (error) {
            this.errorMessage = error.body.message;
        }
    }
}
