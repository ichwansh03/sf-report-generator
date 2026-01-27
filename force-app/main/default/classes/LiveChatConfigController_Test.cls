@isTest
public class LiveChatConfigController_Test {
    public testMethod static void testInit(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            lcc.init();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testEditWorkHour(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            PageReference myVfPage = Page.LiveChatConfigEditWH;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('dayid','1');
            ApexPages.currentPage().getParameters().put('dayName','SENIN');
            ApexPages.currentPage().getParameters().put('startHour','8');
            ApexPages.currentPage().getParameters().put('startMin','0');
            ApexPages.currentPage().getParameters().put('endHour','17');
            ApexPages.currentPage().getParameters().put('endMin','0');
            ApexPages.currentPage().getParameters().put('workDay','true');
            lcc.editWorkHour();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testSaveWorkHour(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            lcc.day_id = '1';
            lcc.saveWorkHour();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testEditMessageActive(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            PageReference myVfPage = Page.LiveChatConfigEditMsg;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('msgStatus','active');
            ApexPages.currentPage().getParameters().put('channel','Facebook');
            ApexPages.currentPage().getParameters().put('value','test');
            lcc.editMessage();
             ApexPages.currentPage().getParameters().put('msgStatus','active');
            ApexPages.currentPage().getParameters().put('channel','Whatsapp');
            ApexPages.currentPage().getParameters().put('value','test');
            lcc.editMessage();
            ApexPages.currentPage().getParameters().put('msgStatus','inactive');
            ApexPages.currentPage().getParameters().put('channel','Facebook');
            ApexPages.currentPage().getParameters().put('value','test');
            lcc.editMessage();
            ApexPages.currentPage().getParameters().put('msgStatus','inactive');
            ApexPages.currentPage().getParameters().put('channel','Whatsapp');
            ApexPages.currentPage().getParameters().put('value','test');
            lcc.editMessage();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testSaveMessage(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            lcc.channel = 'Facebook';
            lcc.saveMessageActive();
            lcc.saveMessageInactive();
            lcc.channel = 'Whatsapp';
            lcc.saveMessageActive();
            lcc.saveMessageInactive();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testSetAsDefault(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            PageReference myVfPage = Page.LiveChatConfig;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('day_id','1');
            lcc.setAsDefaultWorkHour();
            ApexPages.currentPage().getParameters().put('channel','Facebook');
            lcc.setAsDefaultMessageActive();
            lcc.setAsDefaultMessageInactive();
            ApexPages.currentPage().getParameters().put('channel','Whatsapp');
            lcc.setAsDefaultMessageActive();
            lcc.setAsDefaultMessageInactive();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testUpload(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            String dateBody = 'Holiday\n2020-01-01\n2020-01-02';
            LiveChatConfigController lcc = new LiveChatConfigController();
            lcc.document = new Document();
            lcc.document.body = Blob.valueOf(dateBody);
            lcc.document.FolderId = UserInfo.getUserId();
            lcc.document.name = 'Test';
            lcc.uploadHolidayDates();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testNewHoliday(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            lcc.startAddHolidayDates();
            lcc.addHolidayDates();
            LiveChatConfigController.HolidayDates hd = new LiveChatConfigController.HolidayDates();
            hd.value = Date.valueOf('2020-01-20');
            lcc.newHoliday.add(hd);
            LiveChatConfigController.HolidayDates hd2 = new LiveChatConfigController.HolidayDates();
            hd2.value = Date.valueOf('2020-01-19');
            lcc.newHoliday.add(hd2);
            lcc.saveNewHolidayDates();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage());
        }
    }
    
    public testMethod static void testRemoveHoliday(){
        Test.setMock(HttpCalloutMock.class, new WorkingTimeConfigJSONMock());
        WorkingTimeConfigJSON result = new WorkingTimeConfigJSON();
        try{
            LiveChatConfigController lcc = new LiveChatConfigController();
            LiveChatConfigController.HolidayDates hd = new LiveChatConfigController.HolidayDates();
            lcc.newHoliday = new List<LiveChatConfigController.HolidayDates>();
            hd.value = Date.valueOf('2020-01-20');
            lcc.newHoliday.add(hd);
            PageReference myVfPage = Page.LiveChatConfig;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('hol_date','2020-01-20');
            lcc.removeHolidayDates();
            lcc.removeAllHolidayDates();
            hd.value = Date.valueOf('2020-01-20');
            lcc.newHoliday.add(hd);
            ApexPages.currentPage().getParameters().put('cnt','0');
            lcc.minusHolidayDates();
        }catch(Exception e){
            system.debug('Error == '+e.getMessage()+' line '+e.getLineNumber());
        }
    }
}