public with sharing class GenderApiNamedCredentialsApex {
    public static void getDetails(){
        // API Endpoint (HTTPS)
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:GenderFreeApi');
        request.setMethod('GET');
        request.setTimeout(60000); // 60 seconds timeout
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            system.debug(result);
            system.debug('Name'+result.get('name'));
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
        }
    }
}
