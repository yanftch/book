package com.yanftch.book

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.yanftch.book.Constants.EXTRA_ID
import com.yanftch.book.utils.BaseUtils.isNotEmpty
import org.jetbrains.anko.UI
import org.jetbrains.anko.textView
import org.jetbrains.anko.verticalLayout

/**
 *
 * Author : yanftch
 * Date   : 2019-10-15
 * Time   : 10:51
 * Desc   : 测试页面
 */

class TestActivity : AppCompatActivity() {

    var testId: String? = null

    companion object {
        fun handleDeepLink(context: Context, uri: Uri): Intent? {
            var intent: Intent? = null
            val id = uri.getQueryParameter(EXTRA_ID)

            if (isNotEmpty(id)) {
                intent = Intent(context, TestActivity::class.java)
                        .putExtra(EXTRA_ID, id)
            }

            return intent
        }
    }

    fun handleIntent() {
        if (intent.hasExtra(EXTRA_ID)) {
            testId = intent.getStringExtra(EXTRA_ID)
            Log.e("debug_TestActivity", "handleIntent: testId===$testId")
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent()
        setContentView(createView())
    }


    fun createView(): View = UI {
        verticalLayout {
            textView { text = "测试页面..." }
            textView {
                text = "传过来的 id 是：$testId"
            }
        }
    }.view
}
