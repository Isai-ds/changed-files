public with sharing class DecodeString {
    public static String decodeString(String s){
        Stack decode = new Stack();
        Stack current = new Stack();
        for (Integer item : s.getChars()){
            if (isOpenBracket(item)){                
                decode.push(String.fromCharArray((List<Integer>)current.toIntegerList()));
                current.clear();  
            }else if (isClosedBracket(item)){          
                if (!current.isEmpty()){
                    decode.push(String.fromCharArray((List<Integer>)current.toIntegerList()));      
                }
                current.clear();
                System.debug('current::'+current);
                String v = stringMultiplication(decode);
                System.debug('decode::'+decode);
                if (!decode.isEmpty()){
                    String last = (String)decode.pop();
                    Integer lastChar = last.charAt(last.length() - 1);
                    if (isAlpha(lastChar)){
                        decode.push(last + v);
                    }else{
                        decode.push(last);
                        decode.push(v);
                    }
                }else{
                    decode.push(v);
                }
                System.debug('decode::'+decode);
                
            }else{
                if (current.isEmpty()){
                    current.push(item);
                }else{
                    Integer lastItem = (Integer)current.peek();
                    if (isDigit(item)){ 
                        if (isAlpha(lastItem)){
                            decode.push(String.fromCharArray((List<Integer>)current.toIntegerList()));
                            current.clear();                            
                        }
                    }else{
                        if (isDigit(lastItem)){
                            decode.push(String.fromCharArray((List<Integer>)current.toIntegerList()));
                            current.clear();   
                        }
                    }
                    current.push(item);
                }
                
            }
        }
        if (decode.isEmpty())
            return String.fromCharArray((List<Integer>)current.toIntegerList());
        
        return String.join(decode.toList(),'');
    }

    private static String stringMultiplication (Stack s){
        String encodeString = (String)s.pop();
        String v = (String)s.pop();
        String r = '';
        for(Integer i = 0; i< Integer.valueOf(v); i++){
            r += encodeString;
        }
        return r;
    }

    private static Boolean isOpenBracket (Integer value){
        return value == 91;
    }

    private static Boolean isClosedBracket (Integer value){
        return value == 93;
    }

    private static Boolean isAlpha (Integer value){
        return value >= 97 && value <= 122;
    }

    private static Boolean isDigit (Integer value){
        return value >= 48 && value <= 57;
    }
}
