package com.yanftch.book.utils;

/**
 * User : yanftch
 * Date : 2019-10-13
 * Time : 15:56
 * Desc :
 */
public class BaseUtils {
    /**
     * 安全判断字符串是否为空
     */
    public static boolean isEmpty(CharSequence str) {
        return str == null || str.length() == 0;
    }

    public static boolean isNotEmpty(CharSequence str) {
        return !isEmpty(str);
    }

}
