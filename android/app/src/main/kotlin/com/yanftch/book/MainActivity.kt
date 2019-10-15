package com.yanftch.book

import android.os.Bundle
import com.yanftch.book.flutter.AppMethodCallHandler
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    companion object {
        const val CHANNEL_APP = "book/app"

    }

    lateinit var appChannelHandler: AppMethodCallHandler

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // TODO: 2019-10-15  不能直接引用 this 易造成内存泄漏， 暂时使用 ，
        appChannelHandler = AppMethodCallHandler(this)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, CHANNEL_APP).setMethodCallHandler(appChannelHandler)

    }
}
