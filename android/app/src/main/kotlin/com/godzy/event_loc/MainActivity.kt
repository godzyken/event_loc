package com.godzy.event_loc

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.TextView
import com.google.android.material.button.MaterialButton
import com.google.gson.GsonBuilder
import com.google.gson.JsonParser
import com.squareup.okhttp.Callback
import com.squareup.okhttp.OkHttpClient
import com.squareup.okhttp.Request
import com.squareup.okhttp.Response
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.User
import java.io.IOException


class MainActivity : FlutterActivity() {

    companion object {
        const val USERS_QUERY = "https://www.googleapis.com/customsearch/v1?key=INSERT_YOUR_API_KEY&cx=017576662512468239146:omuauf_lfve&q=users&callback=hndlr"
    }

    private lateinit var users: MutableList<User.UserModel>
    private lateinit var list: LinearLayout

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_flutter_user)
        list = findViewById(R.id.list_item)

        val httpClient = OkHttpClient()
        val userRequest = Request.Builder()
            .url(USERS_QUERY)
            .build()

        httpClient.newCall(userRequest).enqueue(object : Callback {
            override fun onFailure(request: Request?, e: IOException?) {
                throw e!!
            }

            override fun onResponse(response: Response?) {
                response.run {
                    if (response != null) {
                        if(!response.isSuccessful) throw IOException("Unexpected code $response")

                        users = parseGoogleUsersJsonToUsers(response.body().string())
                    }

                    val spinner = findViewById<ProgressBar>(R.id.action_bar_spinner)

                    runOnUiThread {

                        spinner.visibility = View.GONE
                        populateUserCards()
                    }
                }
            }

        })
    }

    private fun parseGoogleUsersJsonToUsers(jsonBody: String) : MutableList<User.UserModel> {
        val jsonUsers = JsonParser.parseString(jsonBody).asJsonObject.getAsJsonArray("items")
        val users = mutableListOf<User.UserModel>()

        for(jsonUser in jsonUsers.map { it.asJsonObject }) {
            try {
                val user = User.UserModel()
                val userInfo = jsonUser.asJsonObject.getAsJsonObject("userInfo")
                user.firstname = userInfo.get("firstname")?.asString
                user.lastname = userInfo.get("firstname").asString
                user.email = userInfo.get("firstname").asString
                user.location = userInfo.get("firstname").asString
                user.phone = userInfo.get("firstname").asString
                user.state = userInfo.get("firstname").asString
                user.type = userInfo.get("firstname").asString
                user.avatarUrl.url = userInfo.get("avatarUrl").asString
                users.add(user)
            } catch (e: Exception) {
                println("Failed to parse book:")
                println(GsonBuilder().setPrettyPrinting().create().toJson(jsonUser))
                println("Parsing error:")
                println(e)
            }
        }
        return users
    }

    private fun populateUserCards() {
        for ((index, user) in users.withIndex()) {
            val card = layoutInflater.inflate(R.layout.content_flutter_user, null)
            updateCardUser(card, user)
            card.findViewById<MaterialButton>(R.id.edit_query).setOnClickListener{
                startActivityForResult(
                    FlutterUserActivity
                        .withUser(this, users[index]), index
                )
            }
            list.addView(card)

        }
    }

    private fun updateCardUser(card: View, user: User.UserModel) {
        card.findViewById<TextView>(R.id.title).text = user.firstname
        card.findViewById<TextView>(R.id.title).text = user.lastname
        card.findViewById<TextView>(R.id.title).text = user.email
        card.findViewById<TextView>(R.id.title).text = user.location
        card.findViewById<TextView>(R.id.title).text = user.phone
        card.findViewById<TextView>(R.id.title).text = user.state
        card.findViewById<TextView>(R.id.title).text = user.type
        card.findViewById<TextView>(R.id.title).text = user.avatarUrl.url
        card.findViewById<TextView>(R.id.title).text = resources.getString(R.string.common_google_play_services_enable_title, user.firstname)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == RESULT_OK) {
            if (data == null) {
                throw RuntimeException("The FlutterUserActivity returning RESULT_OK should always have a return data intent")
            }

            val returnedUser = FlutterUserActivity.getUserFromResultIntent(data)

            users[requestCode] = returnedUser

            updateCardUser(list.getChildAt(requestCode), returnedUser)
        }
    }

}




