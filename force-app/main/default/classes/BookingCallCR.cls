global class BookingCallCR implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Date targetDate = getPreviousWorkday(Date.today(), 2);
        DateTime endOfDay = targetDate.addDays(1);
        DateTime dtNow = System.now();

        System.debug('targetDate: ' + targetDate);
        System.debug('endOfDay: ' + endOfDay);

        
        // Replace token jika ada
        DateTime startOfDay = DateTime.newInstance(targetDate, Time.newInstance(0, 0, 0, 0));

        // Gabungkan query
        // Ambil query dari satu Custom Label
        String fullQuery = Label.BookingCallCR_FullQuery;
        System.debug('fullQuery = ' + fullQuery);

        // Replace token waktu
        fullQuery = safeReplace(fullQuery, ':targetDate', startOfDay.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''));
        fullQuery = safeReplace(fullQuery, ':endOfDay', endOfDay.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''));

        List<Call_Line__c> uncontactedCallLines = Database.query(fullQuery);
        System.debug('Total ditemukan: ' + uncontactedCallLines.size());

        List<Email_SMS_Log__c> whatsappLogs = new List<Email_SMS_Log__c>();

        for (Call_Line__c call : uncontactedCallLines) {
            Email_SMS_Log__c ESLog = new Email_SMS_Log__c();
            ESLog.Status__c = 'New';
            ESLog.Ready_To_Send__c = true;
            ESLog.MOT__c = 'Booking Call CR';
            ESLog.Entity__c = call.Entity__c;
            ESLog.Request_Date__c = dtNow.date();
            ESLog.Start_Date__c = dtNow.date();
            ESLog.Category__c = 'BookingCall';
            ESLog.Type__c = 'CCC';
            ESLog.Method__c = 'Whatsapp';
            ESLog.Survey_Type__c = 'Booking Call CR';
            ESLog.Account__c = call.Contact__r.AccountId;
            ESLog.Contact__c = call.Contact__c;
            ESLog.Contact_Short_Name__c = call.Contact__r.LastName;
            ESLog.Mobile__c = call.Contact__r.MobilePhone;
            ESLog.Call_Line__c = call.Id;

            whatsappLogs.add(ESLog);
        }

        if (!whatsappLogs.isEmpty()) {
            try {
                insert whatsappLogs;
                List<Id> logIds = new List<Id>();
                for (Email_SMS_Log__c log : whatsappLogs) {
                    logIds.add(log.Id);
                }

                if (!Test.isRunningTest()) {
                    Database.executeBatch(new JatisWhatsappBatch(logIds), 10);
                }
            } catch (Exception e) {
                System.debug('Gagal Insert atau Execute Batch: ' + e.getMessage());
            }
        }
    }

    // Helper: Replace token jika ada
    private static String safeReplace(String input, String token, String value) {
        return input.contains(token) ? input.replace(token, value) : input;
    }

    // Helper: Dapatkan N hari kerja sebelumnya
    public static Date getPreviousWorkday(Date startDate, Integer daysBack) {
        Integer count = 0;
        Date currentDate = startDate;

        while (count < daysBack) {
            currentDate = currentDate.addDays(-1);
            Integer isoDayOfWeek = Integer.valueOf(DateTime.newInstance(currentDate, Time.newInstance(0, 0, 0, 0)).format('u'));
            if (isoDayOfWeek <= 5) {
                count++;
            }
        }
        return currentDate;
    }

    // Helper: Format tanggal seperti Campaign_Name__c → 2025624
    private static String getCampaignDateFormat(Date currentDate) {
        return String.valueOf(currentDate.year()) +
               String.valueOf(currentDate.month()) +
               String.valueOf(currentDate.day());
    }
}