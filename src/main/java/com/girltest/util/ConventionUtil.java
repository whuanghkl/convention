package com.girltest.util;

/**
 * Created by huangweii on 2015/12/27.
 */
public class ConventionUtil {
    public static String convertBr(String input) {
        if (null == input) {
            return input;
        }
        return input.replaceAll("\r\n", "<br>").replaceAll("\n", "<br>");
    }

    public static boolean filterKeyword(String queryKeyword) {
        if ("恶心".equals(queryKeyword) || "变态".equals(queryKeyword) || "rr".equals(queryKeyword)
                || "大姨妈".equals(queryKeyword)
                || "刘钰大姨妈".equals(queryKeyword)
                || "性观念".equals(queryKeyword)
                || "做爱".equals(queryKeyword)
                || "性爱".equals(queryKeyword)
                || "rr大姨妈".equals(queryKeyword)
                || "rr生日".equals(queryKeyword)
                || "rr爱好".equals(queryKeyword)
                || "rr习惯".equals(queryKeyword)) {
            return true;
        }
        return false;
    }
}
