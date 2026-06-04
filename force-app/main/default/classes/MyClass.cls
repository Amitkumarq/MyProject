public class MyClass {
    
    Boolean isTrue;
    
    public static Integer add(Integer a, Integer b){
        system.debug(a+b);
        return a+b;
    }
    
    Public static Integer add(Integer a, Integer b, Integer c){
        system.debug(a+b+c);
        return a+b+c;
    }
    
    MyClass(){
        this.isTrue = false;
    }
    
    public static Integer calculateAge(Date dob) {
        Date today = Date.today();
        Integer years = today.year() - dob.year();

        if (today.month() < dob.month() ||
           (today.month() == dob.month() && today.day() < dob.day())) {
            years--;
        }

        return years;
    }
}