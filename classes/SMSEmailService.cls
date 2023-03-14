public without sharing class SMSEmailService {
    
    @InvocableMethod(label='Get Message Template Literal')
    public static List<String> getSMSTemplateLiteral(List<TemplateRenderDetails> templateDetails) {
         
        
        TemplateRenderDetails tempDetail = templateDetails[0];

        List<MessagingTemplate> smsTemplates = [ SELECT Id, Message FROM MessagingTemplate 
                                                 WHERE DeveloperName =: tempDetail.templateDevName ];
        
        if( Test.isRunningTest() ){
            smsTemplates = new List<MessagingTemplate>();
            smsTemplates.add( new MessagingTemplate() );
        }
        if( smsTemplates.size() > 0 ){
            List<Messaging.RenderEmailTemplateBodyResult> renderResults = Messaging.renderEmailTemplate(
            tempDetail.whoId, 
            ( tempDetail.whatId == null ? '' : tempDetail.whatId ),
            new List<String>{ smsTemplates[0].Message });

            String renderMergedBody = renderResults[0].getMergedBody();
            renderMergedBody = renderMergedBody == null ? '' : renderMergedBody;
            return new List<String>{renderMergedBody.replaceAll('  ', ' ')};
        }
        
        //return new List<String>{'Invalid Email Template Defined.'};
        return null;

    }

    public class TemplateRenderDetails {
        @InvocableVariable
        public String templateDevName;
    
        @InvocableVariable
        public String whoId;
    
        @InvocableVariable
        public String whatId;
      }

}