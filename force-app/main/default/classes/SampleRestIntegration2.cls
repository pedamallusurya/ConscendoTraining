public with sharing class ApiPincodeSimple {
    
    public static void getPlaces(String pincode) {
        // Create HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.postalpincode.in/pincode/' + pincode);
        req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        // Deserialize JSON into a list of wrapper classes
        List<WrapperClass> wrapperList = (List<WrapperClass>) JSON.deserialize(res.getBody(), List<WrapperClass>.class);
        
        if (!wrapperList.isEmpty() && wrapperList[0].PostOffice != null) {
            // Get all branch types
            List<String> branchTypes = new List<String>();
            
            for (InnerWrapperClass postOffice : wrapperList[0].PostOffice) {
                branchTypes.add(postOffice.BranchType);
            }
            
            System.debug('Branch Types: ' + branchTypes);
        } else {
            System.debug('No Post Offices found for this pincode.');
        }
    }
    
    // Outer wrapper
    public class WrapperClass {
        public String Message;
        public String Status;
        public List<InnerWrapperClass> PostOffice;
    }
    
    // Inner wrapper
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
