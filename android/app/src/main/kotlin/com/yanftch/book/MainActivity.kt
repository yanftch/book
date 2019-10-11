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
        appChannelHandler = AppMethodCallHandler(applicationContext)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, CHANNEL_APP).setMethodCallHandler(appChannelHandler)

    }
}
