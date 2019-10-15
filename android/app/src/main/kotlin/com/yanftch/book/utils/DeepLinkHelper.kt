package com.yanftch.book

import android.content.Context
import android.content.Intent
import android.net.Uri
import com.yanftch.book.utils.BaseUtils.isEmpty
import com.yanftch.book.utils.BaseUtils.isNotEmpty
import org.jetbrains.anko.toast
import java.util.*

/**
 *
 * User : yanftch
 * Date : 2019-10-13
 * Time : 15:50
 * Desc :
 */
object DeepLinkHelper {
    val SCHEME_BOOK = "book"
    val EXTRA_REFERRAL_PAGE_NAME = "referral_page_name"


    fun getDeepLinkIntent(context: Context,
                          uri: Uri,
                          eventContext: Int): Intent? {

        if (isEmpty(uri.scheme)) {
            // 无scheme的情况按本站的相对路径处理
            context.toast("URI not found...")
            return null
        }

        var intent: Intent? = null
        when (uri.scheme.toLowerCase(Locale.US)) {
            SCHEME_BOOK -> intent = getIntentForScheme(context, uri, eventContext)
            else ->
                // 其他scheme交给系统处理
                intent = Intent(Intent.ACTION_VIEW, uri).addCategory(Intent.CATEGORY_BROWSABLE)
        }

        addIntentExtendParameter(uri, intent)
        return intent
    }

    /**
     * 从uri中解析出扩展参数加到intent中
     */
    private fun addIntentExtendParameter(uri: Uri, intent: Intent?): Intent? {
        val referer = uri.getQueryParameter("referer")
        if (isNotEmpty(referer) && intent != null) {
            intent.putExtra(EXTRA_REFERRAL_PAGE_NAME, referer)
        }
        return intent
    }

    private fun getIntentForScheme(context: Context, uri: Uri, eventContext: Int): Intent? {
        var intent: Intent? = null
        val host = uri.host
        when (host) {
            "test_page" -> intent = TestActivity.handleDeepLink(context, uri)
        }

        return intent
    }
}