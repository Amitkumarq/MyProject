public class BasicLearn{
    public static void marks(){
        Map<String,Integer> mp = new Map<String,Integer>();
        mp.put('Amit',50);
        mp.put('Arafat',88);
        mp.put('Rohan',55);
        mp.put('john',90);
        mp.put('snow',59);
        
        Integer maxMarks = 0;
        
        for(integer it: mp.values()){
            if(it>maxMarks){
                maxMarks = it;
            }
        }
        system.debug(maxMarks);
    }
}