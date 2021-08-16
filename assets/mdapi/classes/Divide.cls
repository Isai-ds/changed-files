public with sharing class Divide {
    static Long MIN_VALUE = -2147483648L;
    static Long MAX_VALUE = 2147483647;
    public static Long divide(Long dividend, Long divisor) {
        Long quotient = 0;
        if (dividend == MIN_VALUE && divisor == -1){
            return MAX_VALUE;
        }
        Integer negatives = 2;
        if (dividend > 0){
            negatives --;
            dividend = -dividend;
        }
        if (divisor > 0){
            negatives --;
            divisor = -divisor;
        }

        while (divisor >= dividend){
            Integer powOf2 = -1;
            Long d = divisor;
            while (d  + d >= dividend){
                d+=d;
                powOf2 += powOf2;
            }
            dividend -= d;
            quotient += powOf2;
        }


        if (negatives != 1){
            quotient = -quotient;
        }

        return quotient;
    }
}
