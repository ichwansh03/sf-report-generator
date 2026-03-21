public class ReportToSOQLController {

    public String  selectedReportId   { get; set; }
    public String  selectedReportName { get; set; }
    public String  searchKeyword      { get; set; }
    public String  generatedSOQL      { get; set; }
    public Boolean hasSearchResults   { get; set; }
    public String endpointUrl 		  { get; set; }

    private static final String API_VERSION = 'v61.0';

    public List<ReportWrapper> reportSearchResults { get; set; }

    public ReportToSOQLController() {
        reportSearchResults = new List<ReportWrapper>();
        hasSearchResults    = false;
    }

    public void searchReports() {
        reportSearchResults = new List<ReportWrapper>();
        hasSearchResults    = false;

        if (String.isBlank(searchKeyword) || searchKeyword.trim().length() < 2) return;

        String keyword = '%' + String.escapeSingleQuotes(searchKeyword.trim()) + '%';

        for (Report r : [
            SELECT Id, Name
            FROM Report
            WHERE Name LIKE :keyword
            ORDER BY Name ASC
            LIMIT 20
        ]) {
            reportSearchResults.add(new ReportWrapper(r.Id, r.Name));
        }

        hasSearchResults = !reportSearchResults.isEmpty();
    }

    /*public void selectAndGenerate() {
        // Reset
        generatedSOQL    = null;
        hasSearchResults = false;
        reportSearchResults = new List<ReportWrapper>();
        ApexPages.getMessages().clear();

        if (String.isBlank(selectedReportId)) {
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR, 'No report selected.'
            ));
            return;
        }

        try {
            generatedSOQL = ReportToSOQLConverter.getSOQLFromReport((Id) selectedReportId);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR, 'Error generating SOQL: ' + e.getMessage()
            ));
        }
    }*/
    
    public void selectAndGenerate() {
        generatedSOQL = null;
        endpointUrl   = null;
        hasSearchResults = false;
        reportSearchResults = new List<ReportWrapper>();
        ApexPages.getMessages().clear();
        
        if (String.isBlank(selectedReportId)) {
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR, 'No report selected.'
            ));
            return;
        }
        
        try {
            generatedSOQL = ReportToSOQLConverter.getSOQLFromReport((Id) selectedReportId);
            
            // Build endpoint URL
            String instanceUrl = URL.getOrgDomainUrl().toExternalForm();
            String encodedSOQL = generatedSOQL.replace(' ', '+');
            endpointUrl = instanceUrl + '/services/data/' + API_VERSION + '/query?q=' + encodedSOQL;

            
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR, 'Error generating SOQL: ' + e.getMessage()
            ));
        }
    }


    public class ReportWrapper {
        public String id   { get; set; }
        public String name { get; set; }

        public ReportWrapper(Id rId, String rName) {
            this.id   = String.valueOf(rId);
            this.name = rName;
        }
    }
}