public class QueueableManager {

    public static void enqueue(BaseQueueable queueable) {
        enqueue(new List<BaseQueueable>{queueable});   
    }
    
    public static void enqueue(List<BaseQueueable> queueables) {
        List<Async_Request__c> asyncReqToInsert = new List<Async_Request__c>();
        Integer availableLimit = Limits.getLimitQueueableJobs() - Limits.getQueueableJobs();
        
        Integer threadCount = 0;
        Integer threadLimit = availableLimit;
        
        for (BaseQueueable queueable : queueables) {
            queueable.thread = threadCount;
            String paramJson = JSON.serialize(queueable);
            System.debug('@queueuable'+queueable);
            
            Async_Request__c asyncReq = new Async_Request__c();
            asyncReq.Apex_Class_Name__c = getObjectType(queueable);
            asyncReq.Params__c = paramJson.length() > 131072 ? paramJson.substring(0,131071) : paramJson;
            asyncReq.Thread__c = threadCount;
            
            if (availableLimit > 0) {
                asyncReq.Async_Apex_Job_Id__c = System.enqueueJob(queueable);
                asyncReq.Status__c = 'Enqueued';
                availableLimit--;
            }
            asyncReqToInsert.add(asyncReq);
            threadCount++;
            if (threadCount >= threadLimit) threadCount = 0;
        }
        
        insert asyncReqToInsert;
    }
    
    public static void enqueueNextJob(Integer currentThread) {
        Savepoint savepoint;
        
        try {
            Id currentUserId = UserInfo.getUserId();
            List<Async_Request__c> asyncReqs = [SELECT Apex_Class_Name__c, Params__c, Thread__c FROM Async_Request__c WHERE Status__c = 'New' AND (CreatedById = :currentUserId OR LastModifiedById = :currentUserId) AND Thread__c = :currentThread LIMIT 1 FOR UPDATE];
            
            if (asyncReqs.isEmpty()) {
                    return;
                }

            Async_Request__c asyncRequest = asyncReqs[0];
            BaseQueueable queueable;
            try{
                queueable =
                    (BaseQueueable) JSON.deserialize(
                        asyncRequest.Params__c, Type.forName(asyncRequest.Apex_Class_Name__c)
                    )
                ;
                queueable.thread = currentThread;
            } catch (Exception ex) {
                asyncRequest.Status__c = 'Error';
                asyncRequest.Error_Message__c =
                    ex.getTypeName() + ': ' + ex.getMessage() + '; cause: ' + ex.getCause() + '; line number: '
                        + ex.getLineNumber() + '; stack trace: ' + ex.getStackTraceString()
                ;
                update asyncRequest;
                
                enqueueNextJob(currentThread);
                return;
            }

            savepoint = Database.setSavepoint();
            Id jobId = System.enqueueJob(queueable);
            asyncRequest.Status__c = 'Enqueued';
            asyncRequest.Async_Apex_Job_Id__c = jobId;
            update asyncRequest;

        } catch (Exception e) {
            Database.rollback(savepoint);
            system.debug('error enqueuing job: '+e.getMessage());
        }
    }
    
    private static String getObjectType(Object obj) {
        String result = 'DateTime';
        
        try {
            DateTime typeCheck = (DateTime) obj;
        } catch (System.TypeException te) {
            String message = te.getMessage().substringAfter('Invalid conversion from runtime type ');
            result = message.substringBefore(' to Datetime');
        }
        
        return result;
    }
}