package Controllers;

import Models.GoogleAccount;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;

import Constant.CommonConst;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author ADMIN
 */
public class GoogleLogin {

    public static String getToken(String code) throws IOException {
        String response = Request.Post(CommonConst.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", CommonConst.GOOGLE_CLIENT_ID)
                                .add("client_secret", CommonConst.GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", CommonConst.GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", CommonConst.GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static GoogleAccount getUserInfo(final String accessToken) throws IOException {
        String link = CommonConst.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        GoogleAccount googlePojo = new Gson().fromJson(response, GoogleAccount.class);
        return googlePojo;
    }
}
