package com.yanftch.book.flutter

import android.content.Context
import android.util.Log
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import javax.inject.Inject

/**
 * User : yanftch
 * Date : 2019-10-11
 * Time : 15:28
 * Desc : Flutter 与原生交互的通道
 */
class AppMethodCallHandler @Inject constructor(val context: Context) : MethodChannel.MethodCallHandler {


    private var pendingResult: MethodChannel.Result? = null

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        val method = methodCall.method

        val isPending = when (method) {
            "open" -> onOpenPage(methodCall, result)
            "toast" -> showToasts(methodCall, result)
            else -> {
                result.notImplemented()
                false
            }
        }
        if (isPending) pendingResult = result

    }

    private fun showToasts(methodCall: MethodCall, result: MethodChannel.Result): Boolean {
        val args = methodCall.arguments as? Map<*, *> ?: return false
        val msg = args["message"] as String

        Log.e("debug_AppMethodCallHandler", "showToasts: 调用了原生的 toast, 内容是：$msg")
        Toast.makeText(context, msg, Toast.LENGTH_LONG).show()
        return false
    }

    private fun onOpenPage(methodCall: MethodCall, result: MethodChannel.Result): Boolean {
        val args = methodCall.arguments as Map<*, *>?
        Log.d("debug_", "opening native page: args=$args")

        val url = args?.get("url") as? String
        if (url.isNullOrEmpty()) {
            result.success(null)
            return false
        }
        var intent = null
//        val intent = DeepLinkHelper.getDeepLinkIntent(theContext, Uri.parse(url), 0)
        return if (intent != null) {
            // 打开指定页面，并尝试把结果返回给Flutter
//            startActivityForResult(intent, REQ_RETURN_RESULT)
            true
        } else {
            result.success(null)
            false
        }
    }

}