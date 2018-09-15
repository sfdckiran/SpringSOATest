@isTest
private class TestSampleCallout {
    
    @TestSetup
    static void prepareData(){//Creating custom setting for testing
        Remote_Site_List__c remoteSite = new Remote_Site_List__c();
        remoteSite.Name = 'test';
        remoteSite.Remote_Setting_Name__c = 'Sample_site';
        remoteSite.Remote_Setting_URL__c = 'https://postman-echo.com/get?foo1=bar1&foo2=bar2';
        insert remoteSite;
    }
     @isTest static void testCallout() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpMockClass());
        HttpResponse response = SampleCallout.getData();
        Test.stopTest();
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '{"name":"testName"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
}