public with sharing class MyFirstClass {
    public static void getBranchType(String pincode) {
           Http h = new Http();
           HttpRequest request = new HttpRequest();
           request.setEndpoint('https://api.postalpincode.in/pincode/');
           request.setMethod('GET');
           HttpResponse response = h.send(request);
           List<Object> responseList = (List<Object>) JSON.deserializeUntyped(response.getBody());
           Map<String, Object> result = (Map<String, Object>) responseList[0];
           system.debug(result);
           List<object> PostofficeList = (list<object>) result.get('PostOffice');
          for(object obj : PostofficeList){
              Map<String, Object> PostofficeMap = (Map<String, Object>) obj;
              system.debug(PostofficeMap.get('BranchType'));
          }
           
    }
}