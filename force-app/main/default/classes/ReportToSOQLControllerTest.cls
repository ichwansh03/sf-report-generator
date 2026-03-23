@isTest
private class ReportToSOQLControllerTest {

    // ─────────────────────────────────────────────
    // Constructor
    // ─────────────────────────────────────────────
    @isTest
    static void testConstructor_DefaultValues() {
        ReportToSOQLController ctrl = new ReportToSOQLController();

        System.assertEquals(false, ctrl.hasSearchResults);
        System.assertEquals(0, ctrl.reportSearchResults.size());
        System.assertEquals(null, ctrl.selectedReportId);
        System.assertEquals(null, ctrl.generatedSOQL);
        System.assertEquals(null, ctrl.endpointUrl);
    }

    // ─────────────────────────────────────────────
    // searchReports – guard clauses
    // ─────────────────────────────────────────────
    @isTest
    static void testSearchReports_NullKeyword_DoesNothing() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.searchKeyword = null;
        ctrl.searchReports();

        System.assertEquals(false, ctrl.hasSearchResults);
        System.assertEquals(0, ctrl.reportSearchResults.size());
    }

    @isTest
    static void testSearchReports_BlankKeyword_DoesNothing() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.searchKeyword = '   ';
        ctrl.searchReports();

        System.assertEquals(false, ctrl.hasSearchResults);
        System.assertEquals(0, ctrl.reportSearchResults.size());
    }

    @isTest
    static void testSearchReports_OneCharKeyword_DoesNothing() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.searchKeyword = 'A';
        ctrl.searchReports();

        System.assertEquals(false, ctrl.hasSearchResults);
        System.assertEquals(0, ctrl.reportSearchResults.size());
    }

    @isTest
    static void testSearchReports_ValidKeyword_ResetsStaleState() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.hasSearchResults = true;
        ctrl.reportSearchResults.add(new ReportToSOQLController.ReportWrapper(
            UserInfo.getUserId(), 'Stale Report'
        ));

        ctrl.searchKeyword = 'zzNonExistentReportXYZ';
        ctrl.searchReports();

        System.assertEquals(false, ctrl.hasSearchResults);
        System.assertEquals(0, ctrl.reportSearchResults.size());
    }

    @isTest
    static void testSearchReports_MatchingKeyword_PopulatesResults() {
        List<Report> existing = [SELECT Id, Name FROM Report LIMIT 1];
        if (existing.isEmpty()) return;

        String keyword = existing[0].Name.left(4);
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.searchKeyword = keyword;

        Test.startTest();
        ctrl.searchReports();
        Test.stopTest();

        System.assertEquals(true, ctrl.hasSearchResults);
        System.assert(ctrl.reportSearchResults.size() > 0);
        System.assertNotEquals(null, ctrl.reportSearchResults[0].id);
        System.assertNotEquals(null, ctrl.reportSearchResults[0].name);
    }

    // ─────────────────────────────────────────────
    // selectAndGenerate – guard clauses
    // ─────────────────────────────────────────────
    @isTest
    static void testSelectAndGenerate_NullReportId_AddsErrorMessage() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.selectedReportId = null;
        ctrl.selectAndGenerate();

        List<ApexPages.Message> msgs = ApexPages.getMessages();
        System.assertEquals(1, msgs.size());
        System.assertEquals(ApexPages.Severity.ERROR, msgs[0].getSeverity());
        System.assert(msgs[0].getDetail().contains('No report selected'));
    }

    @isTest
    static void testSelectAndGenerate_BlankReportId_AddsErrorMessage() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.selectedReportId = '   ';
        ctrl.selectAndGenerate();

        System.assertEquals(1, ApexPages.getMessages().size());
    }

    @isTest
    static void testSelectAndGenerate_ResetsStateBeforeProcessing() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.generatedSOQL = 'SELECT Id FROM Account';
        ctrl.endpointUrl = 'https://stale.example.com';
        ctrl.hasSearchResults = true;
        ctrl.selectedReportId = null;

        ctrl.selectAndGenerate();

        System.assertEquals(null, ctrl.generatedSOQL);
        System.assertEquals(null, ctrl.endpointUrl);
        System.assertEquals(false, ctrl.hasSearchResults);
        System.assertEquals(0, ctrl.reportSearchResults.size());
    }

    @isTest
    static void testSelectAndGenerate_InvalidId_AddsErrorMessage() {
        ReportToSOQLController ctrl = new ReportToSOQLController();
        ctrl.selectedReportId = UserInfo.getUserId(); // valid Id format but wrong SObject type

        Test.startTest();
        ctrl.selectAndGenerate();
        Test.stopTest();

        List<ApexPages.Message> msgs = ApexPages.getMessages();
        System.assertEquals(1, msgs.size());
        System.assertEquals(ApexPages.Severity.ERROR, msgs[0].getSeverity());
        System.assert(msgs[0].getDetail().startsWith('Error generating SOQL:'));
    }

    // ─────────────────────────────────────────────
    // ReportWrapper
    // ─────────────────────────────────────────────
    @isTest
    static void testReportWrapper_SetsFieldsCorrectly() {
        Id fakeId = UserInfo.getUserId();
        String fakeName = 'My Test Report';

        ReportToSOQLController.ReportWrapper w =
            new ReportToSOQLController.ReportWrapper(fakeId, fakeName);

        System.assertEquals(String.valueOf(fakeId), w.id);
        System.assertEquals(fakeName, w.name);
    }
}