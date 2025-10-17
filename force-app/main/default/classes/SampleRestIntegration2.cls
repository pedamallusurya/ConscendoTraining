public with sharing class SampleRestIntegration2 {
    public static void getPlaces(String pincode) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.postalpincode.in/pincode/' + pincode);
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        // Log the raw response body to inspect its structure
        System.debug('Response Body: ' + res.getBody());
        // Deserialize based on the actual structure of the response
        List<WrapperClass> wrapperList = (List<WrapperClass>) JSON.deserialize(res.getBody(), List<WrapperClass>.class);
        for (WrapperClass wrapper : wrapperList) {
            for (InnerWrapperClass wrp : wrapper.PostOffice) {
                System.debug(wrp.BranchType);
            }
        }
    }
 
    public class WrapperClass {
        public String Message;
        public String Status;
        public List<InnerWrapperClass> PostOffice;
    }
 
    public class InnerWrapperClass {
        public String Name;
        public String BranchType;
        public String DeliveryStatus;
        public String District;
        public String Division;
        public String Region;
        public String Block;
        public String State;
        public String Country;
        public Integer Pincode;
    }
}