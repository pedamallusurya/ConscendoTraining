public with sharing class IntegrationNamedCredentials {
    public static void hitSalesforceUsingNC(){
        List<Map<String, String>> accounts = new List<Map<String, String>>();
        accounts.add(new Map<String, String>{'Name' => 'Sudheer Rupam 14', 'phone' => '9876543456'});
        accounts.add(new Map<String, String>{'Name' => 'Sudheer Rupam 15', 'phone' => '8765434567'});
        String requestBody = JSON.serialize(accounts);
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');
        req.setEndpoint('callout:CromptonProject/services/apexrest/getAccounts');
        req.setBody(requestBody);
        Http http2 = new Http();
        HttpResponse endRes = http2.send(req);
        System.debug('endRes Code: '+endRes.getStatusCode());
    }
}