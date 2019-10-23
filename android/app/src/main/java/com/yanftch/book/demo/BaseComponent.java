package com.yanftch.book.demo;

import dagger.Component;

/**
 * User : yanftch
 * Date : 2019-10-15
 * Time : 17:39
 * Desc :
 */
@Component(modules = BaseModule.class)
public interface BaseComponent {
    void inject(TestActivity testActivity);
}
