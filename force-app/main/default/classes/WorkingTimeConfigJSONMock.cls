@isTest
global class WorkingTimeConfigJSONMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
      
        String sJsonResponse = '{"status":"Success","data":{"working_hour":[{"day_id":1,"day":"SENIN","work":true,"start_hour":8,"start_min":0,"end_hour":17,"end_min":0},{"day_id":2,"day":"SELASA","work":true,"start_hour":8,"start_min":0,"end_hour":17,"end_min":0},{"day_id":3,"day":"RABU","work":true,"start_hour":8,"start_min":0,"end_hour":17,"end_min":0},{"day_id":4,"day":"KAMIS","work":true,"start_hour":8,"start_min":0,"end_hour":17,"end_min":0},{"day_id":5,"day":"JUMAT","work":true,"start_hour":8,"start_min":0,"end_hour":17,"end_min":0},{"day_id":6,"day":"SABTU","work":false,"start_hour":0,"start_min":0,"end_hour":23,"end_min":0},{"day_id":7,"day":"MINGGU","work":false,"start_hour":0,"start_min":0,"end_hour":23,"end_min":0}],"messages":{"on_facebook":"Ami coba hubungkan kamu dengan teman AMI ya","off_facebook":"Hai, saat ini layanan live chat dengan CS AXA Mandiri hanya tersedia pkl. 08:00 - 17:00 di hari kerja. Silahkan hubungi kembali pada waktu tersebut ya. Terima kasih","on_whatsapp":"Ami coba hubungkan kamu dengan teman AMI ya","off_whatsapp":"Hai, saat ini layanan live chat dengan CS AXA Mandiri hanya tersedia pkl. 08:00 - 17:00 di hari kerja. Silahkan hubungi kembali pada waktu tersebut ya. Terima kasih"},"holiday_dates":["2020-01-01","2020-12-25","2020-02-01","2020-12-29"]},"message":null,"statusCode":null}';
        
        res.setBody(sJsonResponse);
        res.setStatusCode(200);
        
        return res; 
    }
}