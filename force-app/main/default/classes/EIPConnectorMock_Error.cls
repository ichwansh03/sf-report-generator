@isTest
global class EIPConnectorMock_Error implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        String body = req.getBody();
        system.debug('request body: '+body);
        // Default success
        String sJsonResponse = '{"Body": {"transactionId": "1234567890", "status": "1"}}';

        if (body != null) {
            // Token fetch path
            if (body.contains('client_id')) {
                sJsonResponse = '{"access_token": "qwerty123", "scope": "general", "expires_in": 3600, "token_type": "Bearer"}';
            }
            else if (body.contains('TRIGGER_OFFLINE')) {
                system.debug('offline EIP');
                sJsonResponse = '{"Body":{"exception":{"system":"DMTM","code":"250003","backEndError":"(RET=X) Data not found","message":"Response Not Available"},"service":"getCustomerInfo","appID":"DMTM","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"900-109-7575050"}],"key":"9c7e5752-e525-4153-a5de-8459dda44d38#10.47.130.71#SFDCEIP"},"operation":"Customer Profile","transactionId":"123a","entity":"AMFS","status":"0"}}';
            } else if (body.contains('TRIGGER_NODATA')) {
                String noDataCode = System.Label.WS_NoData_ErrCode;
                if (String.isBlank(noDataCode)) noDataCode = 'NO_DATA_CODE_TEST';
                if (noDataCode == '280001') noDataCode = noDataCode + '_ND';
                sJsonResponse = '{"Body": {"transactionId": "X", "status": "0", "exceptionObj": {"code": "' + String.escapeSingleQuotes(noDataCode) + '", "message": "Customer not found", "backEndError": ""}}}';
                system.debug('no data EIP');
            } else if (body.contains('TRIGGER_EIPEXC')) {
                system.debug('exception EIP');
                sJsonResponse = '{"Body": {"transactionId": "X", "status": "0", "exceptionObj": {"code": "", "message": "Some business error", "backEndError": "XYZ"}}}';
            } else if (body.contains('TRIGGER_BADJSON')) {
                system.debug('trigger BADJSON');
				sJsonResponse = 'INVALID_JSON';
			}
        }

        res.setBody(sJsonResponse);
        res.setStatusCode(200);
        return res;
    }
}