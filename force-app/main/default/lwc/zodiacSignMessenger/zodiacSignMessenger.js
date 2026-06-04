import { LightningElement, track } from 'lwc';

export default class ZodiacFinder extends LightningElement {
    userName = '';
    dob = '';

    @track selectedZodiac;

    zodiacTraits = [
        {
            sign: 'Capricorn',
            from: '12-22',
            to: '01-19',
            emoji: '🐐',
            trait: 'Disciplined and practical.'
        },
        {
            sign: 'Aquarius',
            from: '01-20',
            to: '02-18',
            emoji: '💧',
            trait: 'Creative and original.'
        },
        {
            sign: 'Pisces',
            from: '02-19',
            to: '03-20',
            emoji: '🐟',
            trait: 'Emotional and imaginative.'
        },
        {
            sign: 'Aries',
            from: '03-21',
            to: '04-19',
            emoji: '🔥',
            trait: 'Bold and energetic.'
        },
        {
            sign: 'Taurus',
            from: '04-20',
            to: '05-20',
            emoji: '🐂',
            trait: 'Stable and loyal.'
        },
        {
            sign: 'Gemini',
            from: '05-21',
            to: '06-20',
            emoji: '👯',
            trait: 'Smart and witty.'
        },
        {
            sign: 'Cancer',
            from: '06-21',
            to: '07-22',
            emoji: '🦀',
            trait: 'Caring and emotional.'
        },
        {
            sign: 'Leo',
            from: '07-23',
            to: '08-22',
            emoji: '🦁',
            trait: 'Confident and warm.'
        },
        {
            sign: 'Virgo',
            from: '08-23',
            to: '09-22',
            emoji: '🌾',
            trait: 'Practical and organized.'
        },
        {
            sign: 'Libra',
            from: '09-23',
            to: '10-22',
            emoji: '⚖',
            trait: 'Balanced and charming.'
        },
        {
            sign: 'Scorpio',
            from: '10-23',
            to: '11-21',
            emoji: '🦂',
            trait: 'Intense and passionate.'
        },
        {
            sign: 'Sagittarius',
            from: '11-22',
            to: '12-21',
            emoji: '🏹',
            trait: 'Adventurous and free.'
        }
    ];

    // Handle name input
    handleNameChange(event) {
        this.userName = event.target.value;
    }

    // Handle DOB input
    handleDobChange(event) {
        this.dob = event.target.value;
    }

    // Submit button
    handleSubmit() {
        if (!this.dob) {
            return;
        }

        const date = new Date(this.dob);

        const month = String(date.getMonth() + 1);
        const day = String(date.getDate());

        const formattedDate = `${month}-${day}`;

        this.selectedZodiac = this.findZodiac(formattedDate);
    }

    // Find zodiac logic
    findZodiac(formattedDate) {
        for (let zodiac of this.zodiacTraits) {
            if (zodiac.sign === 'Capricorn') {
                if (
                    formattedDate >= zodiac.from ||
                    formattedDate <= zodiac.to
                ) {
                    return zodiac;
                }
            } else {
                if (
                    formattedDate >= zodiac.from &&
                    formattedDate <= zodiac.to
                ) {
                    return zodiac;
                }
            }
        }

        return null;
    }
}
