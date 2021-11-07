package com.godzy.event_loc

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.*
import io.flutter.plugins.*
import java.util.*


class MainActivity : FlutterActivity() {

    private val CHANNEL = "godzy.flutter.dev/home"

    private class MyBookApi : Book.BookModelApi {
        override fun search(keyword: String?): MutableList<Book.BookModel> {
            val random = Random()
            val book = Book.BookModel()
            book.urlImage = "https://source.unsplash.com/random/?book?sig=" + random.nextInt(32)
            book.title = java.lang.String.format("Life %s", keyword)

            return Collections.singletonList(book)
        }
    }

    private class MyUserModelApi(argBinaryMessenger: BinaryMessenger?) : User.UserModelApi(
        argBinaryMessenger
    ) {


        override fun onReply(replyArg: Reply<*>?, callback: Reply<Void>?) {
            super.onReply(replyArg, callback)
            val user = User.UserModel()
            user.id = java.lang.
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        Book.BookModelApi.setup(flutterEngine.dartExecutor.binaryMessenger, MyBookApi())
        User.UserModelApi.Reply<User.UserModel> {
            MyUserModelApi(
                flutterEngine.dartExecutor.binaryMessenger
            )
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler(
            MethodChannel.MethodCallHandler(
                function = (call, ) ->
            )
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        FlutterEngineCache.getInstance().put("my_engine", flutterEngine)
    }


}


