public with sharing class AreFollowingPatterns {

    public static Boolean areFollowingPatterns2 (List<String> strings, List<String> patterns){
        Map<String,String> string2Pattern = new Map<String,String>();
        Map<String,String> pattern2String = new Map<String,String>();
        for (Integer i = 0; i < strings.size(); i++){
            if (string2Pattern.containsKey(strings[i])){
                if (!string2Pattern.get(strings[i]).equals(patterns[i])){
                    return false;
                }
            }else{
                string2Pattern.put(strings[i],patterns[i]);
            }
            
            if (pattern2String.containsKey(patterns[i])){
                if( !pattern2String.get(patterns[i]).equals(strings[i])){
                    return false;
                }
            }else{
                pattern2String.put(patterns[i],strings[i]);    
            }            
        }
        return true;
    }
}