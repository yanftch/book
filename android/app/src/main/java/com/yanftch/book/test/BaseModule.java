package com.yanftch.book.test;

import dagger.Module;

/**
 * User : yanftch
 * Date : 2019-10-15
 * Time : 17:39
 * Desc :
 */
@Module()
public class BaseModule {
    private TestActivity mTestActivity;

    public BaseModule(TestActivity testActivity) {
        this.mTestActivity = testActivity;
    }
}
