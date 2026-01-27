/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AMFS_SplitPenerimaManfaatController_Test {
    @isTest
    static void testplitPenerimaManfaat() {
        String penerima1 = 'AULIA1;9/9/2025;P;1111111111111111;50;ISTRI';
        String penerima2 = 'AULIA2;8/9/2025;P;2222222222222222;40;PAMAN';
        String penerima3 = 'AULIA3;7/9/2025;P;3333333333333333;30;ANAK';
        String penerima4 = 'AULIA4;6/9/2025;P;4444444444444444;20;ANAK';
        String penerima5 = 'AULIA5;5/9/2025;P;5555555555555555;10;ANAK';
        
        // Create test input
        AMFS_SplitPenerimaManfaatController.InputData input = new AMFS_SplitPenerimaManfaatController.InputData();
        input.penerimaManfaat1 = penerima1;
        input.penerimaManfaat2 = penerima2;
        input.penerimaManfaat3 = penerima3;
        input.penerimaManfaat4 = penerima4;
        input.penerimaManfaat5 = penerima5;
        system.debug('##### INPUT :' + input);

        List<AMFS_SplitPenerimaManfaatController.InputData> inputs = new List<AMFS_SplitPenerimaManfaatController.InputData>{input};
        system.debug('##### INPUTS :' + inputs);
        Test.startTest();
        List<AMFS_SplitPenerimaManfaatController.OutputData> outputs = AMFS_SplitPenerimaManfaatController.splitPenerimaManfaat(inputs);
        Test.stopTest();
        system.debug('##### Output :' + outputs);

    }

    @isTest
    static void testplitPenerimaManfaatBlank() {
        String penerima1 = '';
        String penerima2 = '';
        String penerima3 = '';
        String penerima4 = '';
        String penerima5 = '';
        
        // Create test input
        AMFS_SplitPenerimaManfaatController.InputData input = new AMFS_SplitPenerimaManfaatController.InputData();
        input.penerimaManfaat1 = penerima1;
        input.penerimaManfaat2 = penerima2;
        input.penerimaManfaat3 = penerima3;
        input.penerimaManfaat4 = penerima4;
        input.penerimaManfaat5 = penerima5;
        system.debug('##### INPUT :' + input);

        List<AMFS_SplitPenerimaManfaatController.InputData> inputs = new List<AMFS_SplitPenerimaManfaatController.InputData>{input};
        system.debug('##### INPUTS :' + inputs);
        Test.startTest();
        try {
            List<AMFS_SplitPenerimaManfaatController.OutputData> outputs = AMFS_SplitPenerimaManfaatController.splitPenerimaManfaat(inputs);
            
        } catch (Exception e) {
            
        }
        Test.stopTest();
        // system.debug('##### Output :' + outputs);

    }

    @isTest
    static void testplitPenerimaManfaatnull() {
        String penerima1 = null;
        String penerima2 = null;
        String penerima3 = null;
        String penerima4 = null;
        String penerima5 = null;
        
        // Create test input
        AMFS_SplitPenerimaManfaatController.InputData input = new AMFS_SplitPenerimaManfaatController.InputData();
        input.penerimaManfaat1 = penerima1;
        input.penerimaManfaat2 = penerima2;
        input.penerimaManfaat3 = penerima3;
        input.penerimaManfaat4 = penerima4;
        input.penerimaManfaat5 = penerima5;
        system.debug('##### INPUT :' + input);

        List<AMFS_SplitPenerimaManfaatController.InputData> inputs = new List<AMFS_SplitPenerimaManfaatController.InputData>{input};
        system.debug('##### INPUTS :' + inputs);
        Test.startTest();
        try {
            List<AMFS_SplitPenerimaManfaatController.OutputData> outputs = AMFS_SplitPenerimaManfaatController.splitPenerimaManfaat(inputs);
            
        } catch (Exception e) {
            
        }
        Test.stopTest();
        // system.debug('##### Output :' + outputs);

    }

    @isTest
    static void testplitPenerimaManfaatDateEx() {
        String penerima1 = 'AULIA1;9-9 2025;P;1111111111111111;50;ISTRI';
        String penerima2 = 'AULIA2;8-9 2025;P;2222222222222222;40;PAMAN';
        String penerima3 = 'AULIA3;7-9 2025;P;3333333333333333;30;ANAK';
        String penerima4 = 'AULIA4;6-9 2025;P;4444444444444444;20;ANAK';
        String penerima5 = 'AULIA5;5-9 2025;P;5555555555555555;10;ANAK';
        
        // Create test input
        AMFS_SplitPenerimaManfaatController.InputData input = new AMFS_SplitPenerimaManfaatController.InputData();
        input.penerimaManfaat1 = penerima1;
        input.penerimaManfaat2 = penerima2;
        input.penerimaManfaat3 = penerima3;
        input.penerimaManfaat4 = penerima4;
        input.penerimaManfaat5 = penerima5;
        system.debug('##### INPUT :' + input);

        List<AMFS_SplitPenerimaManfaatController.InputData> inputs = new List<AMFS_SplitPenerimaManfaatController.InputData>{input};
        system.debug('##### INPUTS :' + inputs);
        Test.startTest();
        List<AMFS_SplitPenerimaManfaatController.OutputData> outputs = AMFS_SplitPenerimaManfaatController.splitPenerimaManfaat(inputs);
        Test.stopTest();
        system.debug('##### Output :' + outputs);

    }

    @isTest
    static void testplitPenerimaManfaatStringEx() {
        String penerima1 = '123;9-9 2025;P;1111111111111111;50;ISTRI';
        String penerima2 = 'AULIA2;8-9 2025;P;2222222222222222;40;PAMAN';
        String penerima3 = 'AULIA3;7-9 2025;P;3333333333333333;30;ANAK';
        String penerima4 = 'AULIA4;6-9 2025;P;4444444444444444;20;ANAK';
        String penerima5 = 'AULIA5;5-9 2025;P;5555555555555555;10;ANAK';
        
        // Create test input
        AMFS_SplitPenerimaManfaatController.InputData input = new AMFS_SplitPenerimaManfaatController.InputData();
        input.penerimaManfaat1 = penerima1;
        input.penerimaManfaat2 = penerima2;
        input.penerimaManfaat3 = penerima3;
        input.penerimaManfaat4 = penerima4;
        input.penerimaManfaat5 = penerima5;
        system.debug('##### INPUT :' + input);

        List<AMFS_SplitPenerimaManfaatController.InputData> inputs = new List<AMFS_SplitPenerimaManfaatController.InputData>{input};
        system.debug('##### INPUTS :' + inputs);
        Test.startTest();
        try {
            List<AMFS_SplitPenerimaManfaatController.OutputData> outputs = AMFS_SplitPenerimaManfaatController.splitPenerimaManfaat(inputs);
            
        } catch (Exception e) {
            
        }
        Test.stopTest();
        // system.debug('##### Output :' + outputs);
    }
    @isTest
    static void testplitPenerimaManfaatThrow() {
        String penerima1 = '123;9-9 2025;P;1111111111111111;50;ISTRI';
        String penerima2 = 'AULIA2;8-9 2025;P;2222222222222222;40;PAMAN';
        String penerima3 = 'AULIA3;7-9 2025;P;3333333333333333;30;ANAK';
        String penerima4 = 'AULIA4;6-9 2025;P;4444444444444444;20;ANAK';
        String penerima5 = 'AULIA5;5-9 2025;P;5555555555555555;10;ANAK';
        
        // Create test input
        AMFS_SplitPenerimaManfaatController.InputData input = new AMFS_SplitPenerimaManfaatController.InputData();
        AMFS_SplitPenerimaManfaatController.bypassTrigger = true;
        input.penerimaManfaat1 = penerima1;
        input.penerimaManfaat2 = penerima2;
        input.penerimaManfaat3 = penerima3;
        input.penerimaManfaat4 = penerima4;
        input.penerimaManfaat5 = penerima5;
        system.debug('##### INPUT :' + input);

        List<AMFS_SplitPenerimaManfaatController.InputData> inputs = new List<AMFS_SplitPenerimaManfaatController.InputData>{input};
        system.debug('##### INPUTS :' + inputs);
        Test.startTest();
        try {
            List<AMFS_SplitPenerimaManfaatController.OutputData> outputs = AMFS_SplitPenerimaManfaatController.splitPenerimaManfaat(inputs);
            
        } catch (Exception e) {
            
        }
        Test.stopTest();
        // system.debug('##### Output :' + outputs);
    }

}