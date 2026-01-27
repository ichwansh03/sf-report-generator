Global class Terbilang {

    public static Decimal dblMOD(Decimal num1, Decimal num2){
            // MOD Funtion from Decimal Type numbers.
            // Developed by: Wilmer Piedrahita - NEXTANT
            Decimal c = 0;
            Decimal result;
            result = num1 / num2;
            c= Math.floor(result);
            result = num1 - (num2 * c);
            return result;
    }
//*
    public static String AmountText (Decimal Num1) {
        String value1, value2, value3, value4, follower, result;

        IF( Num1 >= 1000000000)
            value4 = String.valueof(Math.FLOOR(Num1 / 1000000000)) + ','; 
        else value4 = '';
    
        IF( Num1 >= 1000000) {
            value3 = String.valueof(Math.FLOOR(Num1 / 1000000)); 
            value3 = value3.RIGHT(3) + ',';
        }
        else value3 = '';

        IF( Num1 >= 1000) {
            value2 = String.valueof(math.FLOOR(Num1 / 1000));
            value2 = value2.RIGHT(3) + ',';
        }
        else value2 = '';
        
        value1 = String.valueof(math.FLOOR(Num1 ));
        value1 = value1.Right(3)+'.';
                    
        IF( dblMOD(Num1 , 1.00) * 100 < 10 ) {

            follower = '0' + String.valueof(Math.ROUND(dblMOD(Num1 , decimal.valueof(1)) * 100.00));
        }
        else follower = String.Valueof(Math.MIN(Math.ROUND(dblMOD(Num1 , 1) * 100.00), 99));    

//        tiny_amount = math.ROUND((math.ABS(the_amount) - large_amount ) * 100.00);
        
        result = value4 + value3 + value2 + value1 + follower;
        // ubah ribuan menjadi titik dan desimal menjadi koma
//        result = result.replace(',','|');
//        result = result.replace('.',',');
//        result = result.replace('|','.');
        return result;
    }

    // tanpa desimal.
    public static String AmountText2 (Decimal Num1) {
        String value1, value2, value3, value4, follower, result;

        IF( Num1 >= 1000000000)
            value4 = String.valueof(Math.FLOOR(Num1 / 1000000000)) + ','; 
        else value4 = '';
    
        IF( Num1 >= 1000000) {
            value3 = String.valueof(Math.FLOOR(Num1 / 1000000)); 
            value3 = value3.RIGHT(3) + ',';
        }
        else value3 = '';

        IF( Num1 >= 1000) {
            value2 = String.valueof(math.FLOOR(Num1 / 1000));
            value2 = value2.RIGHT(3) + ',';
        }
        else value2 = '';
        
        value1 = String.valueof(math.FLOOR(Num1 ));
        value1 = value1.Right(3);
                            
        result = value4 + value3 + value2 + value1;
        // ubah ribuan menjadi titik dan desimal menjadi koma
//        result = result.replace(',','|');
//        result = result.replace('.',',');
//        result = result.replace('|','.');
        return result;
    }

    public static String StringAmountText (String num) { 
    // digunakan untuk nilai yang diatas 1 milliar.
        String num1, num2, value1, value2, value3, follower, result;
       
        num2 = num.LEFT(num.length()-9);
        num1 = num.RIGHT(9);
                
        value2 = Terbilang.AmountText2(decimal.valueof(Num2));
        value1 = Terbilang.AmountText(decimal.valueof(Num1));
        

        if ( decimal.valueof(Num1) < 1)
            result = value2 + ',000,000,00' + value1;
        else if ( decimal.valueof(Num1) < 10)
            result = value2 + ',000,000,00' + value1;
        else if ( decimal.valueof(Num1) < 100)
            result = value2 + ',000,000,0' + value1;
        else if ( decimal.valueof(Num1) < 1000)
            result = value2 + ',000,000,' + value1; //result = value2 + ',000,000' + value1;
        else if ( decimal.valueof(Num1) < 10000)
            result = value2 + ',000,00' + value1;
        else if ( decimal.valueof(Num1) < 100000)
            result = value2 + ',000,0' + value1;
        else if ( decimal.valueof(Num1) < 1000000)
            result = value2 + ',000,' + value1; //result = value2 + ',000' + value1;
        else if ( decimal.valueof(Num1) < 10000000)
            result = value2 + ',00' + value1;
        else if ( decimal.valueof(Num1) < 100000000)
            result = value2 + ',0' + value1;
        else 
            result = value2 + ',' + value1;

        // ubah ribuan menjadi titik dan desimal menjadi koma
//        result = result.replace(',','|');
//        result = result.replace('.',',');
//        result = result.replace('|','.');
        return result;       
    }

    //munculkan desimal
    public static String StringAmountText2 (String num) { 
    // digunakan untuk nilai yang diatas 1 milliar.
        String num1, num2, value1, value2, value3, follower, result;
       
        num2 = num.LEFT(num.length()-11);
        num1 = num.RIGHT(11);
                
        value2 = Terbilang.AmountText2(decimal.valueof(Num2));
        value1 = Terbilang.AmountText(decimal.valueof(Num1)/100);
        

        if ( decimal.valueof(Num1) < 1)
            result = value2 + ',000,000,00' + value1;
        else if ( decimal.valueof(Num1) < 10)
            result = value2 + ',000,000,00' + value1;
        else if ( decimal.valueof(Num1) < 100)
            result = value2 + ',000,000,0' + value1;
        else if ( decimal.valueof(Num1) < 1000)
            result = value2 + ',000,000,' + value1; //result = value2 + ',000,000' + value1;
        else if ( decimal.valueof(Num1) < 10000)
            result = value2 + ',000,00' + value1;
        else if ( decimal.valueof(Num1) < 100000)
            result = value2 + ',000,0' + value1;
        else if ( decimal.valueof(Num1) < 1000000)
            result = value2 + ',000,' + value1; //result = value2 + ',000' + value1;
        else if ( decimal.valueof(Num1) < 10000000)
            result = value2 + ',00' + value1;
        else if ( decimal.valueof(Num1) < 100000000)
            result = value2 + ',0' + value1;
        else 
            result = value2 + ',' + value1;        

        return result;       
    }

    //munculkan desimal
    public static String StringAmountText3 (Decimal num) { 
    // digunakan untuk nilai yang diatas 1 milliar.
        String num1, num2, value1, value2, value3, follower, result;
       
        List<String> args = new String[]{'0','number','###,###,###,###,##0.00'};
        String s = String.format(num.format(),args);
        result = s;
        return result;       
    }
    
    public static String Terbilang (decimal the_amount) {
        String Result = '';
        
//        String[] Format = String.valueof(Nilai).split('', String.valueof(Nilai).length() );
        //Integer divisor;
        decimal divisor;
        Decimal large_amount;
        Decimal     tiny_amount;
        String    the_word;
        Decimal     dividen;
        Decimal     dummy;
        String    weight;
        String    unit;
        String    follower;
        String    prefix;
        String    sufix;
        
        //--SET NOCOUNT ON
        the_word = '';
        large_amount = Math.FLOOR(Math.ABS(the_amount) );
        tiny_amount = math.ROUND((math.ABS(the_amount) - large_amount ) * 100.00);
        divisor = 1000000000000.00;
        
        IF (large_amount > divisor * 1000.00)
            RETURN 'OUT OF RANGE'; 
            
        //WHILE divisor >= 1
        for (integer i = 1; i <= 10; i++)
        {
        if (divisor >= 1)
        {
            dividen = math.FLOOR(large_amount / divisor);
            large_amount = dblMOD(large_amount,divisor);
            
            unit = '';
            IF (dividen > 0.00)
            {
                
                if (divisor == 1000000000000.00) unit= 'Trilyun ';
                else if (divisor == 1000000000.00) unit= 'Milyar ';
                else if (divisor == 1000000.00) unit= 'Juta ';
                else if (divisor == 1000.00) unit= 'Ribu ';
                else unit = '';    
            }
            weight = '';
            dummy = dividen;
            IF (dummy >= 100.00) {
                if (math.FLOOR(dummy / 100.00) == 1) weight= 'Se';
                else if (math.FLOOR(dummy / 100.00) == 2) weight= 'Dua ';
                else if (math.FLOOR(dummy / 100.00) == 3) weight= 'Tiga ';
                else if (math.FLOOR(dummy / 100.00) == 4) weight= 'Empat ';
                else if (math.FLOOR(dummy / 100.00) == 5) weight= 'Lima ';
                else if (math.FLOOR(dummy / 100.00) == 6) weight= 'Enam ';
                else if (math.FLOOR(dummy / 100.00) == 7) weight= 'Tujuh ';
                else if (math.FLOOR(dummy / 100.00) == 8) weight= 'Delapan ';
                else weight= 'Sembilan ';
                
                weight = weight + 'Ratus ';
            }

            dummy = dblMOD(dividen,100);
        
            IF (dummy < 10.00)
            {
                IF ((dummy == 1.00) && (unit == 'Ribu'))
                {
                    IF (dividen==dummy)
                        weight = weight + 'Se';
                    ELSE
                        weight = weight + 'Satu ';
                }
                ELSE IF (dummy > 0.00 )
                
                    if (dummy == 1) weight = weight + 'Satu ';
                    else if (dummy == 2) weight = weight + 'Dua ';
                    else if (dummy == 3) weight = weight + 'Tiga ';
                    else if (dummy == 4) weight = weight + 'Empat ';
                    else if (dummy == 5) weight = weight + 'Lima ';
                    else if (dummy == 6) weight = weight + 'Enam ';
                    else if (dummy == 7) weight = weight + 'Tujuh ';
                    else if (dummy == 8) weight = weight + 'Delapan ';
                    ELSE weight = weight + 'Sembilan ';
            }
            ELSE
            IF (dummy >= 11 && dummy <= 19) {
                if (dblMOD(dummy,10) == 1) weight = weight + 'Se';
                else if (dblMOD(dummy,10) == 2) weight = weight + 'Dua ';
                else if (dblMOD(dummy,10) == 3) weight = weight + 'Tiga ';
                else if (dblMOD(dummy,10) == 4) weight = weight + 'Empat ';
                else if (dblMOD(dummy,10) == 5) weight = weight + 'Lima ';
                else if (dblMOD(dummy,10) == 6) weight = weight + 'Enam ';
                else if (dblMOD(dummy,10) == 7) weight = weight + 'Tujuh ';
                else if (dblMOD(dummy,10) == 8) weight = weight + 'Delapan ';
                ELSE weight = weight + 'Sembilan ';
                    
                weight = weight + 'Belas ';
            }
            ELSE
            {
                if (math.FLOOR(dummy / 10) == 1) weight = weight + 'Se';
                else if (math.FLOOR(dummy / 10) == 2) weight = weight + 'Dua ';
                else if (math.FLOOR(dummy / 10) == 3) weight = weight + 'Tiga ';
                else if (math.FLOOR(dummy / 10) == 4) weight = weight + 'Empat ';
                else if (math.FLOOR(dummy / 10) == 5) weight = weight + 'Lima ';
                else if (math.FLOOR(dummy / 10) == 6) weight = weight + 'Enam ';
                else if (math.FLOOR(dummy / 10) == 7) weight = weight + 'Tujuh ';
                else if (math.FLOOR(dummy / 10) == 8) weight = weight + 'Delapan ';
                ELSE weight = weight + 'Sembilan ';
                
                weight = weight + 'Puluh ';
                    
                IF (dblMOD(dummy,10) > 0 ) {

                    if ( dblMOD(dummy,10) == 1) weight = weight + 'Satu ';
                    else if ( dblMOD(dummy,10) == 2) weight = weight + 'Dua ';
                    else if ( dblMOD(dummy,10) == 3) weight = weight + 'Tiga ';
                    else if ( dblMOD(dummy,10) == 4) weight = weight + 'Empat ';
                    else if ( dblMOD(dummy,10) == 5) weight = weight + 'Lima ';
                    else if ( dblMOD(dummy,10) == 6) weight = weight + 'Enam ';
                    else if ( dblMOD(dummy,10) == 7) weight = weight + 'Tujuh ';
                    else if ( dblMOD(dummy,10) == 8) weight = weight + 'Delapan ';
                    ELSE weight = weight + 'Sembilan ';
                }
            }
            
            the_word = the_word + weight + unit;
            divisor = divisor / 1000.00;
        }}
        
        IF (math.FLOOR(the_amount) == 0.00)
            the_word = 'Nol ';
        
        follower = '';
        // di hide, tidak ada desimal
        /*
        IF (tiny_amount < 10.00)
        {
            IF (tiny_amount > 0.00 )
                if (tiny_amount == 1) follower = 'Koma Nol ' + 'Satu ';
                else if (tiny_amount == 2) follower = 'Koma Nol ' + 'Dua ';
                else if (tiny_amount == 3) follower = 'Koma Nol ' + 'Tiga ';
                else if (tiny_amount == 4) follower = 'Koma Nol ' + 'Empat ';
                else if (tiny_amount == 5) follower = 'Koma Nol ' + 'Lima ';
                else if (tiny_amount == 6) follower = 'Koma Nol ' + 'Enam ';
                else if (tiny_amount == 7) follower = 'Koma Nol ' + 'Tujuh ';
                else if (tiny_amount == 8) follower = 'Koma Nol ' + 'Delapan ';
                ELSE follower = 'Koma Nol ' + 'Sembilan ';
        }
        ELSE
        {
            if (math.FLOOR(tiny_amount / 10.00) == 1) follower = 'Koma ' + 'Satu ';
            else if (math.FLOOR(tiny_amount / 10.00) == 2) follower = 'Koma ' + 'Dua ';
            else if (math.FLOOR(tiny_amount / 10.00) == 3) follower = 'Koma ' + 'Tiga ';
            else if (math.FLOOR(tiny_amount / 10.00) == 4) follower = 'Koma ' + 'Empat ';
            else if (math.FLOOR(tiny_amount / 10.00) == 5) follower = 'Koma ' + 'Lima ';
            else if (math.FLOOR(tiny_amount / 10.00) == 6) follower = 'Koma ' + 'Enam ';
            else if (math.FLOOR(tiny_amount / 10.00) == 7) follower = 'Koma ' + 'Tujuh ';
            else if (math.FLOOR(tiny_amount / 10.00) == 8) follower = 'Koma ' + 'Delapan ';
            ELSE follower = 'Koma ' + 'Sembilan ';
            
            IF (dblMOD(tiny_amount,10) > 0 )
            {
                if (dblMOD(tiny_amount,10) == 1) follower = follower + 'Satu ';
                else if (dblMOD(tiny_amount,10) == 2) follower = follower + 'Dua ';
                else if (dblMOD(tiny_amount,10) == 3) follower = follower + 'Tiga ';
                else if (dblMOD(tiny_amount,10) == 4) follower = follower + 'Empat ';
                else if (dblMOD(tiny_amount,10) == 5) follower = follower + 'Lima ';
                else if (dblMOD(tiny_amount,10) == 6) follower = follower + 'Enam ';
                else if (dblMOD(tiny_amount,10) == 7) follower = follower + 'Tujuh ';
                else if (dblMOD(tiny_amount,10) == 8) follower = follower + 'Delapan ';
                ELSE follower = follower + 'Sembilan ';
            }
        } 
            
        the_word = the_word + follower;
        */
        
        
        
        /* Update untuk menghindari string "kurang" jika amount PS kurang dari 0
        IF (the_amount < 0.00)
            the_word = 'Kurang ' + the_word;
        */

        the_word = the_word.replace('SeRatus','Seratus');
        the_word = the_word.replace('SePuluh','Sepuluh');
        the_word = the_word.replace('SeBelas','Sebelas');

//            the_word = the_word + ' Rupiah';
            the_word = the_word + '';

        RETURN the_word;
//        return Result;
    } // end public 
   

//========================================================
// terbilang USD
    public static String TerbilangUSD (decimal the_amount) {
        String Result = '';
        
//        String[] Format = String.valueof(Nilai).split('', String.valueof(Nilai).length() );
        //Integer divisor;
        decimal divisor;
        Decimal large_amount;
        Decimal     tiny_amount;
        String    the_word;
        Decimal     dividen;
        Decimal     dummy;
        String    weight;
        String    unit;
        String    follower;
        String    prefix;
        String    sufix;
        
        //--SET NOCOUNT ON
        the_word = '';
        large_amount = Math.FLOOR(Math.ABS(the_amount) );
        tiny_amount = math.ROUND((math.ABS(the_amount) - large_amount ) * 100.00);
        divisor = 1000000000000.00;
        
        IF (large_amount > divisor * 1000.00)
            RETURN 'OUT OF RANGE'; 
            
        //WHILE divisor >= 1
        for (integer i = 1; i <= 10; i++)
        {
        if (divisor >= 1)
        {
            dividen = math.FLOOR(large_amount / divisor);
            large_amount = dblMOD(large_amount,divisor);
            
            unit = '';
            IF (dividen > 0.00)
            {
                
                if (divisor == 1000000000000.00) unit= 'Zillion ';
                else if (divisor == 1000000000.00) unit= 'Billion ';
                else if (divisor == 1000000.00) unit= 'Million ';
                else if (divisor == 1000.00) unit= 'Thousand ';
                else unit = '';    
            }
            weight = '';
            dummy = dividen;
            IF (dummy >= 100.00) {
                if (math.FLOOR(dummy / 100.00) == 1) weight= 'SE';
                else if (math.FLOOR(dummy / 100.00) == 2) weight= 'Two ';
                else if (math.FLOOR(dummy / 100.00) == 3) weight= 'Three ';
                else if (math.FLOOR(dummy / 100.00) == 4) weight= 'Four ';
                else if (math.FLOOR(dummy / 100.00) == 5) weight= 'Five ';
                else if (math.FLOOR(dummy / 100.00) == 6) weight= 'Six ';
                else if (math.FLOOR(dummy / 100.00) == 7) weight= 'Seven ';
                else if (math.FLOOR(dummy / 100.00) == 8) weight= 'Eight ';
                else weight= 'Nine ';
                
                weight = weight + 'Hundred ';
            }

            dummy = dblMOD(dividen,100);
        
            IF (dummy < 10.00)
            {
                IF ((dummy == 1.00) && (unit == 'Thousand'))
                {
                    IF (dividen==dummy)
                        weight = weight + 'SE';
                    ELSE
                        weight = weight + 'One ';
                }
                ELSE IF (dummy > 0.00 )
                
                    if (dummy == 1) weight = weight + 'One ';
                    else if (dummy == 2) weight = weight + 'Two ';
                    else if (dummy == 3) weight = weight + 'Three ';
                    else if (dummy == 4) weight = weight + 'Four ';
                    else if (dummy == 5) weight = weight + 'Five ';
                    else if (dummy == 6) weight = weight + 'Six ';
                    else if (dummy == 7) weight = weight + 'Seven ';
                    else if (dummy == 8) weight = weight + 'Eight ';
                    ELSE weight = weight + 'Nine ';
            }
            ELSE
            IF (dummy >= 11 && dummy <= 19) {
                if (dblMOD(dummy,10) == 1) weight = weight + 'SE';
                else if (dblMOD(dummy,10) == 2) weight = weight + 'Two ';
                else if (dblMOD(dummy,10) == 3) weight = weight + 'Three ';
                else if (dblMOD(dummy,10) == 4) weight = weight + 'Four ';
                else if (dblMOD(dummy,10) == 5) weight = weight + 'Five ';
                else if (dblMOD(dummy,10) == 6) weight = weight + 'Six ';
                else if (dblMOD(dummy,10) == 7) weight = weight + 'Seven ';
                else if (dblMOD(dummy,10) == 8) weight = weight + 'Eight ';
                ELSE weight = weight + 'Nine ';
                    
                weight = weight + 'BELAS ';
            }
            ELSE
            {
                if (math.FLOOR(dummy / 10) == 1) weight = weight + 'SE';
                else if (math.FLOOR(dummy / 10) == 2) weight = weight + 'Two ';
                else if (math.FLOOR(dummy / 10) == 3) weight = weight + 'Three ';
                else if (math.FLOOR(dummy / 10) == 4) weight = weight + 'Four ';
                else if (math.FLOOR(dummy / 10) == 5) weight = weight + 'Five ';
                else if (math.FLOOR(dummy / 10) == 6) weight = weight + 'Six ';
                else if (math.FLOOR(dummy / 10) == 7) weight = weight + 'Seven ';
                else if (math.FLOOR(dummy / 10) == 8) weight = weight + 'Eight ';
                ELSE weight = weight + 'Nine ';
                
                weight = weight + 'ty ';
                    
                IF (dblMOD(dummy,10) > 0 ) {

                    if ( dblMOD(dummy,10) == 1) weight = weight + 'One ';
                    else if ( dblMOD(dummy,10) == 2) weight = weight + 'Two ';
                    else if ( dblMOD(dummy,10) == 3) weight = weight + 'Three ';
                    else if ( dblMOD(dummy,10) == 4) weight = weight + 'Four ';
                    else if ( dblMOD(dummy,10) == 5) weight = weight + 'Five ';
                    else if ( dblMOD(dummy,10) == 6) weight = weight + 'Six ';
                    else if ( dblMOD(dummy,10) == 7) weight = weight + 'Seven ';
                    else if ( dblMOD(dummy,10) == 8) weight = weight + 'Eight ';
                    ELSE weight = weight + 'Nine ';
                }
            }
            
            the_word = the_word + weight + unit;
            divisor = divisor / 1000.00;
        }}
        
        IF (math.FLOOR(the_amount) == 0.00)
            the_word = 'Zero ';
        
        follower = '';
        // dihide, karena tidak pakai Point
/*        
        IF (tiny_amount < 10.00)
        {
            IF (tiny_amount > 0.00 )
                if (tiny_amount == 1) follower = 'Point Zero ' + 'One ';
                else if (tiny_amount == 2) follower = 'Point Zero ' + 'Two ';
                else if (tiny_amount == 3) follower = 'Point Zero ' + 'Three ';
                else if (tiny_amount == 4) follower = 'Point Zero ' + 'Four ';
                else if (tiny_amount == 5) follower = 'Point Zero ' + 'Five ';
                else if (tiny_amount == 6) follower = 'Point Zero ' + 'Six ';
                else if (tiny_amount == 7) follower = 'Point Zero ' + 'Seven ';
                else if (tiny_amount == 8) follower = 'Point Zero ' + 'Eight ';
                ELSE follower = 'Point Zero ' + 'Nine ';
        }
        ELSE
        {
            if (math.FLOOR(tiny_amount / 10.00) == 1) follower = 'Point ' + 'One ';
            else if (math.FLOOR(tiny_amount / 10.00) == 2) follower = 'Point ' + 'Two ';
            else if (math.FLOOR(tiny_amount / 10.00) == 3) follower = 'Point ' + 'Three ';
            else if (math.FLOOR(tiny_amount / 10.00) == 4) follower = 'Point ' + 'Four ';
            else if (math.FLOOR(tiny_amount / 10.00) == 5) follower = 'Point ' + 'Five ';
            else if (math.FLOOR(tiny_amount / 10.00) == 6) follower = 'Point ' + 'Six ';
            else if (math.FLOOR(tiny_amount / 10.00) == 7) follower = 'Point ' + 'Seven ';
            else if (math.FLOOR(tiny_amount / 10.00) == 8) follower = 'Point ' + 'Eight ';
            ELSE follower = 'Point ' + 'Nine ';
            
            IF (dblMOD(tiny_amount,10) > 0 )
            {
                if (dblMOD(tiny_amount,10) == 1) follower = follower + 'One ';
                else if (dblMOD(tiny_amount,10) == 2) follower = follower + 'Two ';
                else if (dblMOD(tiny_amount,10) == 3) follower = follower + 'Three ';
                else if (dblMOD(tiny_amount,10) == 4) follower = follower + 'Four ';
                else if (dblMOD(tiny_amount,10) == 5) follower = follower + 'Five ';
                else if (dblMOD(tiny_amount,10) == 6) follower = follower + 'Six ';
                else if (dblMOD(tiny_amount,10) == 7) follower = follower + 'Seven ';
                else if (dblMOD(tiny_amount,10) == 8) follower = follower + 'Eight ';
                ELSE follower = follower + 'Nine ';
            }
        } 
            
        the_word = the_word + follower;
*/        
        IF (the_amount < 0.00)
            the_word = 'MINUS ' + the_word;
        
        // check spell
        the_word = the_word.replace(' ty','ty');
        the_word = the_word.replace('SEHundred','One Hundred');
        the_word = the_word.replace('Eightty','Eighty');
        the_word = the_word.replace('SEBELAS','Eleven');

        the_word = the_word.replace('SEty','Ten');
        the_word = the_word.replace('Twoty','Twenty');
        the_word = the_word.replace('Threety','Thirty');
        
        the_word = the_word.replace('Two BELAS','Twelve');
        the_word = the_word.replace('Three BELAS','Thirteen');
        the_word = the_word.replace('Four BELAS','Fourteen');
        the_word = the_word.replace('Five BELAS','Fifteen');
        the_word = the_word.replace('Six BELAS','Sixteen');
        the_word = the_word.replace('Seven BELAS','Seventeen');
        the_word = the_word.replace('Eight BELAS','Eighteen');
        the_word = the_word.replace('Nine BELAS','Nineteen');

//        the_word = the_word + ' US Dollar';
        the_word = the_word + '';
            
        RETURN the_word;
//        return Result;
    } // end public 
        
//========================================================
/*
    public static String CORE_FN_SATUAN (integer ANGKA, String MataUang ) {

        String strtmp, satbesar, strangka;
        integer lenangka, i , ch;
        //–baca di belakang koma
        
        strangka = String.valueof(ANGKA);
        lenangka = strangka.Legth();
        strtmp = '';
        i = 1;
        while i 2 and i=2) or (lenangka = 2 and i=1) )and ch > 0
        begin
        if UPPER(MataUang) = ‘USD’ set strtmp=strtmp+’ty’
        else set strtmp=strtmp+’ puluh’
        end
        if lenangka > 2 and i=1
        begin
        if UPPER(MataUang) = ‘USD’ set strtmp=strtmp+’ hundred’
        else set strtmp=strtmp+’ ratus’
        end
        
        set i=i+1
        end
        –replace untu gantiin string output dengan yang baru(output yang benar)
        set strtmp = REPLACE(strtmp, ‘satu puluh’,’sepuluh’)
        set strtmp = REPLACE(strtmp, ‘sepuluh satu’,’sebelas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh dua’,’dua belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh tiga’,’tiga belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh empat’,’empat belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh lima’,’lima belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh enam’,’enam belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh tujuh’,’tujuh belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh delapan’,’delapan belas’)
        set strtmp = REPLACE(strtmp, ‘sepuluh sembilan’,’sembilan belas’)
        
        set strtmp = REPLACE(strtmp, ‘satu ratus’,’seratus’)
        set strtmp = REPLACE(strtmp, ‘onety’, ‘ten’)
        set strtmp = REPLACE(strtmp, ‘twoty’, ‘twenty’)
        set strtmp = REPLACE(strtmp, ‘ten one’,’eleven’)
        set strtmp = REPLACE(strtmp, ‘ten two’,’twelve’)
        set strtmp = REPLACE(strtmp, ‘ten three’,’thirdten’)
        set strtmp = REPLACE(strtmp, ‘ten four’,’fourten’)
        set strtmp = REPLACE(strtmp, ‘ten five’,’fiveten’)
        set strtmp = REPLACE(strtmp, ‘ten six’,’sixten’)
        set strtmp = REPLACE(strtmp, ‘ten seven’,’seventen’)
        set strtmp = REPLACE(strtmp, ‘ten eight’,’eightten’)
        set strtmp = REPLACE(strtmp, ‘ten nine’,’nineten’)
        set strtmp = REPLACE(strtmp, ‘eightty’, ‘eighty’)
        RETURN strtmp
        END
    } // end public 
    
CREATE FUNCTION [dbo].[CORE_FN_CORE_TERBILANG](
@input varchar(1024),
@currency varchar(1024)
)
RETURNS varchar(1024)
BEGIN
declare @angka bigint, @koma int

declare @strAngka varchar(1024)
declare @i int, @j int, @ch int, @lenAngka int
declare @satbesar varchar(1024), @strtmp varchar(1024)
declare @strBelakangKoma varchar(255), @belakangKoma int, @angkaKoma int, @jumlahNol int

set @angka = convert(float,(@input))

set @strAngka = convert(varchar(100),@input,0)
set @koma = isnull(CHARINDEX(‘.’,@strAngka),0)
if @koma=null set @koma=0
set @strBelakangKoma = RIGHT(@strAngka, LEN(@strAngka)-@koma)
if @koma > 0
set @strAngka = substring(@strAngka,1, @koma-1)

set @lenAngka = LEN(@strAngka)
set @i=0

–cek angka yang di input 0 atau null
if @angka != 0 or @angka != null
begin
–set @satbesar=convert(varchar(25),@angka,0)
set @strtmp = ”

while @i 3 and LEN(@strAngka) 0
set @satbesar = @satbesar +’ Ribu’
set @strAngka = substring(@strAngka,LEN(@strAngka)-3+1, 3)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 6 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Juta’
set @strAngka = substring(@strAngka,LEN(@strAngka)-6+1, 6)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 9 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Milyar’
set @strAngka = substring(@strAngka,LEN(@strAngka)-9+1, 9)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 12 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Trilyun’
set @strAngka = substring(@strAngka,LEN(@strAngka)-12+1, 12)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 15 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Bilyun’
set @strAngka = substring(@strAngka,LEN(@strAngka)-15+1, 15)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) 3 and LEN(@strAngka) 0
set @satbesar = @satbesar +’ Thousand’
set @strAngka = substring(@strAngka,LEN(@strAngka)-3+1, 3)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 6 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Million’
set @strAngka = substring(@strAngka,LEN(@strAngka)-6+1, 6)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 9 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Billion’
set @strAngka = substring(@strAngka,LEN(@strAngka)-9+1, 9)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 12 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Zillion’
set @strAngka = substring(@strAngka,LEN(@strAngka)-12+1, 12)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka) > 15 and LEN(@strAngka) 0 set @satbesar = @satbesar +’ Billion’
set @strAngka = substring(@strAngka,LEN(@strAngka)-15+1, 15)
–set @strtmp=@strtmp+’ ‘ +@satbesar
end
else if LEN(@strAngka)<= 3
begin
set @satbesar = dbo.CORE_FN_SATUAN(substring(@strAngka,1, LEN(@strAngka)+3),@currency)
set @strAngka = substring(@strAngka,LEN(@strAngka)+3-1, 3)
end
end

set @strtmp=@strtmp+’ ‘ +@satbesar
set @i=@i+1
end
end

–baca di belakang koma
if ((@angka != 0 or @angka != null) and @input like ‘%.%’ )
begin
set @lenAngka = 0
set @lenAngka = LEN(@strBelakangKoma)
set @angkaKoma = ”

–baca banyaknya angka nol di belakang koma — jika diawali dg koma 0
if (substring(convert(varchar(100),@input,0),@koma+1,1) = ‘0’)
begin
set @jumlahNol = 1
set @i = 0

while @i @jumlahNol) or –jika jumlah koma(@lenAngka) lebih besar dari jumlah 0
((substring(convert(varchar(100),@input,0),@koma+1,1) != ‘0’))) –jika koma tidak di awali dengan angka 0
begin
if UPPER(@currency) = ‘USD’
set @strtmp=@strtmp+’ Point’
else
set @strtmp=@strtmp+’ Koma’
set @i=0
while @i<@lenAngka –+1
begin
set @ch = convert(int,substring(@strBelakangKoma,@i+1,1))
if UPPER(@currency) = ‘IDR’
begin
select @satbesar =
case @ch
when 0 then ‘ Nol’
when 1 then ‘ Satu’
when 2 then ‘ Dua’
when 3 then ‘ Tiga’
when 4 then ‘ Empat’
when 5 then ‘ Lima’
when 6 then ‘ Enam’
when 7 then ‘ Tujuh’
when 8 then ‘ Delapan’
when 9 then ‘ Sembilan’
end
end

if UPPER(@currency) = ‘USD’
begin
select @satbesar =
case @ch
when 0 then ‘ Zero’
when 1 then ‘ One’
when 2 then ‘ Two’
when 3 then ‘ Three’
when 4 then ‘ Four’
when 5 then ‘ Five’
when 6 then ‘ Six’
when 7 then ‘ Seven’
when 8 then ‘ Eight’
when 9 then ‘ Nine’
end
end
set @strtmp=@strtmp+@satbesar
set @i=@i+1
end
end
end

set @strtmp = REPLACE(@strtmp, ‘ ‘, ‘ ‘)
set @strtmp = REPLACE(@strtmp, ‘Satu Ribu’,’Seribu’)

if UPPER(@currency)=’IDR’
begin
set @strtmp = @strtmp +’ Rupiah ‘
end

if UPPER(@currency)=’USD’
begin
set @strtmp = @strtmp +’ Dollar ‘
end

set @strtmp = REPLACE(@strtmp, ‘ ‘,’ ‘)
set @strtmp = REPLACE(@strtmp, ‘ ‘,’ ‘)

return @strtmp
END
//    */
} // end Global Class