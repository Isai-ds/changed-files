public with sharing class AmendTheSentence {

    public static String amendTheSentence(String s) {
        //Test
        List<Integer> result = new List<Integer>();
        result.add( isUpperCase(s.charAt(0)) ? s.charAt(0) + 32 : s.charAt(0) );
        for (Integer i = 1; i < s.length(); i++){
            Integer c = s.charAt(i);
            if (isUpperCase(c)){
                result.add(32);
                result.add(c + 32);
                continue;
            }
            result.add(c);
        }
        return String.fromCharArray(result);
    }
    private static Boolean isUpperCase (Integer c){
        return c >= 65 && c <= 90;
    }
}
