@isTest
global class HttpMockClass implements HttpCalloutMock{

    global HTTPResponse respond(HTTPRequest request) {
        
        System.assertEquals('https://postman-echo.com/get?foo1=bar1&foo2=bar2', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"name":"testName"}');
        response.setStatusCode(200);
        return response;
    }
}