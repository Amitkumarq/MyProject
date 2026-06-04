public class DataStructure {
    public static void myListCollection(){
        List<Integer> myList = new List<Integer>{1,2,3,4};
        for(Integer i=0; i<myList.size();i++){
        	myList[i] += 2;
    	}
        system.debug(myList);
    }
    
    public static void mySetCollection(){
        Set<Integer> st = new Set<Integer>{1,2,3,4,5,6};
            system.debug(st.contains(2));
    }
}