package com.yanftch.book.utils

import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull

/**
 * User : yanftch
 * Date : 2019-10-15
 * Time : 18:39
 * Desc : 原生分享工具类
 */

object ShareUtils {

    /** 原生分享纯文字*/
    fun nativeShare(@NonNull context: Context, @NonNull shareContent: String) {
        val intent = Intent()
        intent.action = Intent.ACTION_SEND
        intent.putExtra(Intent.EXTRA_TEXT, shareContent)
        intent.type = "text/plain"
        context.startActivity(intent)
    }
}