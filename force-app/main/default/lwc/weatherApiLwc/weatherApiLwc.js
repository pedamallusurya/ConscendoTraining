import { LightningElement, track } from 'lwc';

export default class CurrentWeatherLwc extends LightningElement {
    @track weather;
    @track error;

    connectedCallback() {
        // 1️⃣ Get current location using browser API
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    const lat = position.coords.latitude;
                    const lon = position.coords.longitude;
                    this.getWeather(lat, lon);
                },
                (err) => {
                    this.error = 'Unable to get location. Please allow access.';
                    console.error(err);
                }
            );
        } else {
            this.error = 'Geolocation is not supported by this browser.';
        }
    }

    // 2️⃣ Fetch weather data from Open-Meteo API
    getWeather(lat, lon) {
        const apiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true`;

        fetch(apiUrl)
            .then((res) => res.json())
            .then((data) => {
                this.weather = data.current_weather;
            })
            .catch((error) => {
                this.error = 'Error fetching weather data.';
                console.error(error);
            });
    }
}
