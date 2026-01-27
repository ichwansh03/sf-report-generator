/**
 * @description       : 
 * @author            : Muh Syafiq Hidayatullah
 * @group             : 
 * @last modified on  : 09-22-2025
 * @last modified by  : Ahmad Yazid Munif
**/
public with sharing class AMFS_SplitPenerimaManfaatController {
    @TestVisible private static Boolean bypassTrigger = false;
    @InvocableMethod(label='splitPenerimaManfaat')
    public static List<OutputData> splitPenerimaManfaat(List<InputData> inputs) {
        List<OutputData> outputList = new List<OutputData>();
        List<String> inputPenerima1 = new List<String>();
        List<String> inputPenerima2 = new List<String>();
        List<String> inputPenerima3 = new List<String>();
        List<String> inputPenerima4 = new List<String>();
        List<String> inputPenerima5 = new List<String>();
        List<String> valuePenerima1 = new List<String>();
        List<String> valuePenerima2 = new List<String>();
        List<String> valuePenerima3 = new List<String>();
        List<String> valuePenerima4 = new List<String>();
        List<String> valuePenerima5 = new List<String>();

        for(InputData input : inputs){
            inputPenerima1.add(input.penerimaManfaat1 != ';//;;;;' ? input.penerimaManfaat1 : ';;;;;');
            inputPenerima2.add(input.penerimaManfaat2 != ';//;;;;' ? input.penerimaManfaat2 : ';;;;;');
            inputPenerima3.add(input.penerimaManfaat3 != ';//;;;;' ? input.penerimaManfaat3 : ';;;;;');
            inputPenerima4.add(input.penerimaManfaat4 != ';//;;;;' ? input.penerimaManfaat4 : ';;;;;');
            inputPenerima5.add(input.penerimaManfaat5 != ';//;;;;' ? input.penerimaManfaat5 : ';;;;;');
        }
        // Penerima 1
        valuePenerima1 = splitValueString(inputPenerima1[0]);
        // Penerima 2
        valuePenerima2 = splitValueString(inputPenerima2[0]);
        // Penerima 3
        valuePenerima3 = splitValueString(inputPenerima3[0]);
        // Penerima 4
        valuePenerima4 = splitValueString(inputPenerima4[0]);
        // Penerima 5
        valuePenerima5 = splitValueString(inputPenerima5[0]);

        OutputData output = new OutputData();
        output.namaLengkap1 = safeToString(valuePenerima1[0]);
        output.namaLengkap2 = safeToString(valuePenerima2[0]) ;
        output.namaLengkap3 = safeToString(valuePenerima3[0]) ;
        output.namaLengkap4 = safeToString(valuePenerima4[0]) ;
        output.namaLengkap5 = safeToString(valuePenerima5[0]) ;
        output.tanggalLahir1 = valuePenerima1[1] != '' ? splitValueDate(valuePenerima1[1]) : null ;
        output.tanggalLahir2 = valuePenerima2[1] != '' ? splitValueDate(valuePenerima2[1]) : null ;
        output.tanggalLahir3 = valuePenerima3[1] != '' ? splitValueDate(valuePenerima3[1]) : null ;
        output.tanggalLahir4 = valuePenerima4[1] != '' ? splitValueDate(valuePenerima4[1]) : null ;
        output.tanggalLahir5 = valuePenerima5[1] != '' ? splitValueDate(valuePenerima5[1]) : null ;
        output.jenisKelamin1 = safeToString(valuePenerima1[2]) ;
        output.jenisKelamin2 = safeToString(valuePenerima2[2]) ;
        output.jenisKelamin3 = safeToString(valuePenerima3[2]) ;
        output.jenisKelamin4 = safeToString(valuePenerima4[2]) ;
        output.jenisKelamin5 = safeToString(valuePenerima5[2]) ;
        output.nomorIdentitas1 = safeToString(valuePenerima1[3]);
        output.nomorIdentitas2 = safeToString(valuePenerima2[3]);
        output.nomorIdentitas3 = safeToString(valuePenerima3[3]);
        output.nomorIdentitas4 = safeToString(valuePenerima4[3]);
        output.nomorIdentitas5 = safeToString(valuePenerima5[3]);
        output.persentase1 = safeToDouble(valuePenerima1[4]);
        output.persentase2 = safeToDouble(valuePenerima2[4]);
        output.persentase3 = safeToDouble(valuePenerima3[4]);
        output.persentase4 = safeToDouble(valuePenerima4[4]);
        output.persentase5 = safeToDouble(valuePenerima5[4]);
        output.hubungan1 = safeToString(valuePenerima1[5]);
        output.hubungan2 = safeToString(valuePenerima2[5]);
        output.hubungan3 = safeToString(valuePenerima3[5]);
        output.hubungan4 = safeToString(valuePenerima4[5]);
        output.hubungan5 = safeToString(valuePenerima5[5]);

        outputList.add(output);

        return outputList;
    }

    // Invocable Input
    public class InputData{
        @InvocableVariable(label = 'Penerima Manfaat 1' required=false)
        public String penerimaManfaat1;
        @InvocableVariable(label = 'Penerima Manfaat 2' required=false)
        public String penerimaManfaat2;
        @InvocableVariable(label = 'Penerima Manfaat 3' required=false)
        public String penerimaManfaat3;
        @InvocableVariable(label = 'Penerima Manfaat 4' required=false)
        public String penerimaManfaat4;
        @InvocableVariable(label = 'Penerima Manfaat 5' required=false)
        public String penerimaManfaat5;
    }

    // Invocable Output
    public class OutputData{
        @InvocableVariable(label =  'Nama Lengkap 1')
        public String namaLengkap1;
        @InvocableVariable(label =  'Nama Lengkap 2')
        public String namaLengkap2;
        @InvocableVariable(label =  'Nama Lengkap 3')
        public String namaLengkap3;
        @InvocableVariable(label =  'Nama Lengkap 4')
        public String namaLengkap4;
        @InvocableVariable(label =  'Nama Lengkap 5')
        public String namaLengkap5;

        @InvocableVariable(label =  'Tanggal Lahir 1')
        public Date tanggalLahir1;
        @InvocableVariable(label =  'Tanggal Lahir 2')
        public Date tanggalLahir2;
        @InvocableVariable(label =  'Tanggal Lahir 3')
        public Date tanggalLahir3;
        @InvocableVariable(label =  'Tanggal Lahir 4')
        public Date tanggalLahir4;
        @InvocableVariable(label =  'Tanggal Lahir 5')
        public Date tanggalLahir5;

        @InvocableVariable(label =  'Jenis Kelamin 1')
        public String jenisKelamin1;
        @InvocableVariable(label =  'Jenis Kelamin 2')
        public String jenisKelamin2;
        @InvocableVariable(label =  'Jenis Kelamin 3')
        public String jenisKelamin3;
        @InvocableVariable(label =  'Jenis Kelamin 4')
        public String jenisKelamin4;
        @InvocableVariable(label =  'Jenis Kelamin 5')
        public String jenisKelamin5;

        @InvocableVariable(label =  'Nomor Identitas 1')
        public String nomorIdentitas1;
        @InvocableVariable(label =  'Nomor Identitas 2')
        public String nomorIdentitas2;
        @InvocableVariable(label =  'Nomor Identitas 3')
        public String nomorIdentitas3;
        @InvocableVariable(label =  'Nomor Identitas 4')
        public String nomorIdentitas4;
        @InvocableVariable(label =  'Nomor Identitas 5')
        public String nomorIdentitas5;

        @InvocableVariable(label =  'Persentase 1')
        public Double persentase1;
        @InvocableVariable(label =  'Persentase 2')
        public Double persentase2;
        @InvocableVariable(label =  'Persentase 3')
        public Double persentase3;
        @InvocableVariable(label =  'Persentase 4')
        public Double persentase4;
        @InvocableVariable(label =  'Persentase 5')
        public Double persentase5;

        @InvocableVariable(label =  'Hubungan 1')
        public String hubungan1;
        @InvocableVariable(label =  'Hubungan 2')
        public String hubungan2;
        @InvocableVariable(label =  'Hubungan 3')
        public String hubungan3;
        @InvocableVariable(label =  'Hubungan 4')
        public String hubungan4;
        @InvocableVariable(label =  'Hubungan 5')
        public String hubungan5;
        
    }

    private static List<String> splitValueString(String paramName) {
        system.debug('INI Value String ========== '+paramName);
        List<String> listValue = new List<String>();
        List<String> listValueDummy = new List<String>{'','','','','',''};
        try {
            if(Test.isRunningTest()) {
                if(bypassTrigger){
                    throw new QueryException('Simulasi error untuk test class');
                }
            }
            if(!String.isBlank(paramName)){
                for(String s : paramName.split(';')){
                    if(!String.isBlank(s)){
                        listValue.add(s);
                    }
                }
            }
            if(listValue.isEmpty()){
                listValue = listValueDummy;
            }
            system.debug(listValue);
            return listValue;
        } catch (Exception e) {
            return null; 
        }
    }
    
    private static Date splitValueDate(String paramName) {
        system.debug('INI ADALAH DATE ========== '+paramName);
        try {
            List<String> parts = paramName.split('/');
            String formatted = parts[2] + '-' + parts[1] + '-' + parts[0];
            Date finalDate = Date.valueOf(formatted);      
            return finalDate;
        } catch (Exception e) {
            return null; 
        }
    }

    private static String safeToString(String val) {
        return String.valueOf(val);
        // system.debug(val);
        // try {
        //     return String.valueOf(val);
        // } catch (Exception e) {
        //     return null; 
        // }
    }

    private static Double safeToDouble(String val) {
        try {
            return Double.valueOf(val);
        } catch (Exception e) {
            return null; 
        }
    }
}