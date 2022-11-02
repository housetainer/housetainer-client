package com.example.housetainer

import android.content.Intent
import androidx.activity.result.ActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import com.navercorp.nid.NaverIdLoginSDK
import com.navercorp.nid.oauth.OAuthLoginCallback
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
    private val authNaverChannel = "auth.social/naver"
    private var pendingResult: MethodChannel.Result? = null
    private val launcher = registerForActivityResult<Intent, ActivityResult>(ActivityResultContracts.StartActivityForResult()) { result ->
        when(result.resultCode) {
            RESULT_OK -> {
                // 네이버 로그인 인증이 성공했을 때 수행할 코드 추가
                pendingResult?.success(NaverIdLoginSDK.getAccessToken())
                pendingResult = null
            }
            RESULT_CANCELED -> {
                // 실패 or 에러
                val errorCode = NaverIdLoginSDK.getLastErrorCode().code
                val errorDescription = NaverIdLoginSDK.getLastErrorDescription()
                pendingResult?.error(errorCode, errorDescription, null)
                pendingResult = null
            }
        }
    }

    private val oauthLoginCallback = object: OAuthLoginCallback {
        override fun onError(errorCode: Int, message: String) {
            pendingResult?.error(errorCode.toString(), message, null)
            pendingResult = null
        }

        override fun onFailure(httpStatus: Int, message: String) {
            pendingResult?.error(httpStatus.toString(), message, "Http")
            pendingResult = null
        }

        override fun onSuccess() {
            pendingResult?.success(NaverIdLoginSDK.getAccessToken())
            pendingResult = null
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        NaverIdLoginSDK.initialize(this, "PPh2H77yRoT8vdxz5zNW", "nvvkSx2GQD", "housetainer")

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, authNaverChannel).setMethodCallHandler {
            call, result ->
            if (call.method == "authNaver") {
                pendingResult = result
                NaverIdLoginSDK.authenticate(this, launcher, oauthLoginCallback)
//                NaverIdLoginSDK.logout()
            }
        }
    }
}
