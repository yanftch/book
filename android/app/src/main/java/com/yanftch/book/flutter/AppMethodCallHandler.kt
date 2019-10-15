package com.yanftch.book.flutter

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.yanftch.book.DeepLinkHelper
import com.yanftch.book.utils.ShareUtils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import javax.inject.Inject

/**
 * User : yanftch
 * Date : 2019-10-11
 * Time : 15:28
 * Desc : Flutter 与原生交互的通道
 */

@SuppressLint("LongLogTag")
class AppMethodCallHandler @Inject constructor(private val context: Context) : MethodChannel.MethodCallHandler {

    private var pendingResult: MethodChannel.Result? = null

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {

        val isPending = when (methodCall.method ?: "") {
            _M_OPEN -> onOpenPage(methodCall, result)
            _M_TOAST -> showToasts(methodCall, result)
            _M_SHARE -> share(methodCall, result)
            else -> {
                result.notImplemented()
                false
            }
        }
        if (isPending) pendingResult = result
    }

    private fun share(methodCall: MethodCall, result: MethodChannel.Result): Boolean {
        val args = methodCall.arguments as? Map<*, *> ?: return false
        val content = args["content"] as String
        Log.e("debug_AppMethodCallHandler", "share: share content--->$content")
        ShareUtils.nativeShare(context, content)
        return false
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
        val intent = DeepLinkHelper.getDeepLinkIntent(context, Uri.parse(url), 0)
        return if (intent != null) {
            // 打开指定页面，并尝试把结果返回给Flutter
            startActivityForResult(intent, REQ_RETURN_RESULT)
            true
        } else {
            result.success(null)
            false
        }
    }

    // TODO: 2019-10-15 提出去，不要放在这
    protected fun startActivityForResult(intent: Intent, requestCode: Int) {
        if (context is Activity) {
            context.startActivityForResult(intent, requestCode)
        } else if (context is android.app.Fragment) {
            (context as android.app.Fragment).startActivityForResult(intent, requestCode)
        } else if (context is Fragment) {
            (context as Fragment).startActivityForResult(intent, requestCode)
        } else {
            throw IllegalStateException("failed to start activity from the context $context")
        }
    }


    companion object {
        private val apiUrlPattern = """^https?://(.*)/api(/v\d+)?$""".toPattern()

        private const val REQ_RETURN_RESULT = 50001
        private const val RESULT_OK = 0
        private const val RESULT_CANCELLED = 1

        private const val TRACKER_GA = 0
        private const val TRACKER_FIREBASE = 1

        // 定义与 flutter 交互的 key

        val _M_OPEN = "open"
        val _M_TOAST = "toast"
        val _M_SHARE = "share"

    }

}