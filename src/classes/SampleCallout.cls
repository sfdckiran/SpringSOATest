public class SampleCallout {
	
    public static HttpResponse getData() {//To make callout and handle response
	Http http = new Http();
	HttpRequest request = new HttpRequest();
    
    String url = [SELECT Remote_Setting_URL__c FROM Remote_Site_List__c WHERE Remote_Setting_Name__c = 'Sample_site'].Remote_Setting_URL__c;
    request.setEndpoint(url);
    request.setMethod('GET');
    HttpResponse response = http.send(request);
	system.debug(response.getBody());
    return response;
  }
}