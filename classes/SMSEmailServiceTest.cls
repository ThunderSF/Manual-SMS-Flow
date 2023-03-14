@isTest
public class SMSEmailServiceTest {
    
    @isTest
    public static void getSMSTemplateLiteralTest(){
        
        Account acc= new Account(Name = 'test acc');
        insert acc;
        
        lead l = new lead(FirstName = 'lead 1',LastName= 'test',Company='test', Phone = '4242310001');
        insert l;  
        
        
        List<MessagingTemplate> messageTmps = [select id, DeveloperName  from MessagingTemplate LIMIT 1];
        
        SMSEmailService.TemplateRenderDetails temp = new SMSEmailService.TemplateRenderDetails();
        temp.templateDevName = 'Test Temp';
        temp.whatId = acc.id;
        temp.whoId = l.id;
        
        list<SMSEmailService.TemplateRenderDetails> tempRender = new list<SMSEmailService.TemplateRenderDetails>{temp};
            
        Test.startTest();
        list<string> result = SMSEmailService.getSMSTemplateLiteral(tempRender);
        Test.stopTest();
        
        //system.Debug('result'+result);
        system.assertNotEquals(null, result);
        
    }
    
    
}