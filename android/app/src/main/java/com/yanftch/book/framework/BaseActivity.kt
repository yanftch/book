package com.yanftch.book.framework

import android.app.Activity
import android.os.Bundle

/**
 *
 * User : yanftch
 * Date : 2019-10-22
 * Time : 14:44
 * Desc : Activity 基类
 */
abstract class BaseActivity :Activity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

}