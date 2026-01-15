@isTest
public class VerifyDateTest {
    
    @isTest
    static void testDateWithin30Days() {
        // Test when date2 is within 30 days of date1
        Date date1 = Date.newInstance(2024, 1, 1);
        Date date2 = Date.newInstance(2024, 1, 15);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        
        System.assertEquals(date2, result, 'Should return date2 when it is within 30 days');
    }
    
    @isTest
    static void testDateExactly30DaysApart() {
        // Test when date2 is exactly 30 days from date1 (should return end of month)
        Date date1 = Date.newInstance(2024, 1, 1);
        Date date2 = Date.newInstance(2024, 1, 31);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expectedEndOfMonth = Date.newInstance(2024, 1, 31);
        
        System.assertEquals(expectedEndOfMonth, result, 'Should return end of month when date2 is 30 days away');
    }
    
    @isTest
    static void testDateMoreThan30DaysApart() {
        // Test when date2 is more than 30 days from date1
        Date date1 = Date.newInstance(2024, 1, 1);
        Date date2 = Date.newInstance(2024, 3, 1);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expectedEndOfMonth = Date.newInstance(2024, 1, 31);
        
        System.assertEquals(expectedEndOfMonth, result, 'Should return end of month when date2 is more than 30 days away');
    }
    
    @isTest
    static void testDate2InPast() {
        // Test when date2 is before date1
        Date date1 = Date.newInstance(2024, 1, 15);
        Date date2 = Date.newInstance(2024, 1, 1);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expectedEndOfMonth = Date.newInstance(2024, 1, 31);
        
        System.assertEquals(expectedEndOfMonth, result, 'Should return end of month when date2 is in the past');
    }
    
    @isTest
    static void testEndOfMonthForFebruary() {
        // Test end of month calculation for February in a non-leap year
        Date date1 = Date.newInstance(2023, 2, 1);
        Date date2 = Date.newInstance(2023, 4, 1);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expectedEndOfMonth = Date.newInstance(2023, 2, 28);
        
        System.assertEquals(expectedEndOfMonth, result, 'Should return Feb 28 for non-leap year');
    }
    
    @isTest
    static void testEndOfMonthForLeapYear() {
        // Test end of month calculation for February in a leap year
        Date date1 = Date.newInstance(2024, 2, 1);
        Date date2 = Date.newInstance(2024, 4, 1);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        Date expectedEndOfMonth = Date.newInstance(2024, 2, 29);
        
        System.assertEquals(expectedEndOfMonth, result, 'Should return Feb 29 for leap year');
    }
    
    @isTest
    static void testDate29DaysApart() {
        // Test when date2 is exactly 29 days from date1 (should return date2)
        Date date1 = Date.newInstance(2024, 1, 1);
        Date date2 = Date.newInstance(2024, 1, 30);
        
        Date result = VerifyDate.CheckDates(date1, date2);
        
        System.assertEquals(date2, result, 'Should return date2 when it is 29 days away');
    }
}