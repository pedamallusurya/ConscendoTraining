public with sharing class WeatherServiceApex {
    public static void getCurrentWeather() {
        // API Endpoint (HTTPS)
        String endpoint = 'https://api.open-meteo.com/v1/forecast?latitude=12.97&longitude=77.59&current_weather=true';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setTimeout(60000); // 60 seconds timeout
        
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> currentWeather = (Map<String, Object>) result.get('current_weather');
            
            System.debug('🌤️ Temperature: ' + currentWeather.get('temperature'));
            System.debug('💨 Wind Speed: ' + currentWeather.get('windspeed'));
            System.debug('🕒 Time: ' + currentWeather.get('time'));
        } else {
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
        }
    }
}
