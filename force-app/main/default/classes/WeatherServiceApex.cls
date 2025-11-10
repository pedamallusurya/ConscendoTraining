public with sharing class WeatherServiceApex {
    @AuraEnabled(cacheable=true)
    public static String getCurrentWeather() {
        String endpoint = 'https://api.open-meteo.com/v1/forecast?latitude=12.54&longitude=67.59&current_weather=true';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setTimeout(60000); // 60 seconds timeout
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            return response.getBody(); // Return JSON as a String
        } else {
            return '{"error":"Failed with status ' + response.getStatusCode() + '"}';
        }
    }
}
