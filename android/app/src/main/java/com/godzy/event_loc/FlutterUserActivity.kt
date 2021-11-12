package com.godzy.event_loc

import android.accounts.AccountManager
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import com.godzy.event_loc.UserApplication.Companion.ENGINE_ID
import com.google.firebase.auth.api.fallback.service.FirebaseAuthFallbackService
import com.google.firebase.firestore.ktx.firestoreSettings
import com.google.firebase.remoteconfig.FirebaseRemoteConfig
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.User
import java.util.*
import java.util.logging.StreamHandler

class FlutterUserActivity : FlutterActivity() {
    private val CHANNEL_NAME = "godzy.flutter.dev/channel"
    private val AUTH_CHANNEL = "godzy.flutter.dev/auth"

    private var methodChannel: MethodChannel? = null
    private lateinit var authManager: AccountManager
    private var authChannel: EventChannel? = null
    private var authStreamHandler: StreamHandler? = null

    private var firebaseStorage: FirebaseAuthFallbackService? = null
    private var remoteConfig: FirebaseRemoteConfig? = null
    private var firebaseRemoteConfigSettings: FirebaseRemoteConfigSettings? = null

    companion object {
        const val Extra_USER = "user"

        /**
         * Static intent factory to start {@link FlutterBookActivity} with the singleton
         * {@link FlutterEngine} the application started.
         *
         * The activity launched from this intent shows the details of the {@link User.UserModel}
         * supplied.
         */
        fun withUser(context: Context, user: User.UserModel): Intent {
            // In a more realistic app, there should be some dependency injection mechanism to
            // determine which engine to use.
            return CachedEngineUserIntentBuilder(ENGINE_ID)
                .build(context)
                .putExtra(
                    // The Pigeon data class is useful not only between Kotlin/Java and Dart
                    // but also within Kotlin/Java where activities must communicate with
                    // each other via serializable data. The Pigeon data class is a
                    // serializable class by definition.
                    Extra_USER,
                    // the Pigeon generated data class should just implement
                    // Serializable so we won't need 'toMap()' here
                    // https://github.com/flutter/flutter/issues/58909
                    listOf(user).lastIndexOf(user)
                )
        }

        /**
         *  A static helper method to parse a result intent from this activity into a {@link Book}.
         *
         * @param resultIntent an {@link Intent} that must be the data intent returned by this
         *                     activity's {@code onActivityResult}.
         */
        fun getUserFromResultIntent(resultIntent: Intent): User.UserModel {
            return User.UserModel().apply { firestoreSettings { getHost() } }
        }
    }

    // Intent builder class to build a FlutterBookActivity instance instead of the default FlutterActivity.
    class CachedEngineUserIntentBuilder(engineId: String): CachedEngineIntentBuilder(FlutterUserActivity::class.java, engineId) {
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val userModelToShow = User.UserModel()

        User.UserModelApi.setup(flutterEngine.dartExecutor.binaryMessenger, MyUserModelApi())
        User.FlutterUserApi(flutterEngine.dartExecutor).displayUserDetails(userModelToShow
        ) {
            MyUserModelApi()
        }

    }

    inner class MyUserModelApi() : User.UserModelApi {

        override fun cancel() {
//            TODO("Not yet implemented")
            setResult(Activity.RESULT_CANCELED)
            finish()
        }

        override fun finishEditingProfile(userModel: User.UserModel?) {
            if (userModel == null) {
                throw IllegalArgumentException("finishedEditingUser cannot be called with a null argument")
            }

            setResult(Activity.RESULT_OK, Intent().putExtra(Extra_USER, listOf(userModel).lastIndexOf(userModel)))
            finish()
        }

        override fun getUser(keyword: String?): MutableList<User.UserModel>? {

            if (keyword == null) {
                throw IllegalArgumentException("getUser cannot be called with a null argument")
            }

            val user = User.UserModel()
            user.firstname = java.lang.String.format("Life %s", keyword)
            user.lastname = java.lang.String.format("Life %s", keyword)
            user.email = java.lang.String.format("Life %s", keyword)
            user.avatarUrl.url = java.lang.String.format("Life %s", keyword)
            user.location = java.lang.String.format("Life %s", keyword)
            user.phone = java.lang.String.format("Life %s", keyword)
            user.type = java.lang.String.format("Life %s", keyword)
            user.state = java.lang.String.format("Life %s", keyword)


            setResult(Activity.RESULT_OK)
            finish()

            return Collections.singletonList(user)
        }

    }

    private fun setupChannels(context: Context, messenger: BinaryMessenger) {
        authManager = context.getSystemService(Context.ACCOUNT_SERVICE) as AccountManager

        methodChannel = MethodChannel(messenger, CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler{
            call, result ->
            if (call.method == "isAuthAvailable") {
                result.success(authManager.accounts)
            } else {
                result.notImplemented()
            }
        }

        authChannel = EventChannel(messenger, AUTH_CHANNEL)
//        authStreamHandler = StreamHandler(authManager, Account.KEY_ACCOUNT_TYPE)
//        authChannel!!.setStreamHandler(authStreamHandler)
    }

//    private fun teatdownChannels() {
//        methodChanneL!!.setMethodCallHandler(null)
//        authChannel!!.setStreamHandler(null)
//    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        firebaseRemoteConfigSettings?.let {
            remoteConfig?.setConfigSettingsAsync(
                it
            )?.apply {
                val defaultMode = mutableListOf<AccountManager>()
                defaultMode.also {
                    apply {
                        addOnCompleteListener(Activity()) {
                            addOnSuccessListener(
                                FlutterUserActivity()
                            ) {
                                result
                            }
                        }
                    }
                    also {
                        println("Sorting the list")
                    }
                }
            }

            remoteConfig?.let { firebaseRemoteConfig ->
                changingConfigurations.compareTo(taskId)
            }

            remoteConfig?.fetchAndActivate()?.addOnCompleteListener(this) { taskId ->
                if (taskId.isSuccessful) {
                    val updated = taskId.result
                    Log.d(ENGINE_ID, "Config params updated: $updated")
                    Toast.makeText(
                        this, "Fetch and activate succeeded",
                        Toast.LENGTH_SHORT
                    ).show()
                } else {
                    Toast.makeText(
                        this, "Fetch failed",
                        Toast.LENGTH_SHORT
                    ).show()
                }
                onFlutterUiDisplayed()
            }

            remoteConfig?.setDefaultsAsync(R.xml.flutter_image_picker_file_paths)
        }
    }

}
