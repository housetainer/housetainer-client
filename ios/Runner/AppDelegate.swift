import UIKit
import Flutter
import NaverThirdPartyLogin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var flutterResult: FlutterResult? = nil
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let naverSocialLoginChannel = FlutterMethodChannel(name: "auth.social/naver",
                                                  binaryMessenger: controller.binaryMessenger)
        
        naverSocialLoginChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "authNaver" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            self?.flutterResult = result
            self?.authNaver()
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        super.application(app, open: url, options: options)
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        return true
    }
    
    private func authNaver() {
        guard let conn = NaverThirdPartyLoginConnection.getSharedInstance() else {
            flutterResult?(FlutterMethodNotImplemented)
            flutterResult = nil
            return
        }
        conn.isNaverAppOauthEnable = false
        conn.isInAppOauthEnable = true
        conn.isOnlyPortraitSupportedInIphone()
        conn.serviceUrlScheme = kServiceAppUrlScheme
        conn.consumerKey = kConsumerKey
        conn.consumerSecret = kConsumerSecret
        conn.appName = kServiceAppName
        
        conn.delegate = self
        conn.requestThirdPartyLogin()
//        conn.requestDeleteToken()
    }
}

extension AppDelegate: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        flutterResult?(NaverThirdPartyLoginConnection.getSharedInstance().accessToken)
        flutterResult = nil
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        return
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        flutterResult?(NaverThirdPartyLoginConnection.getSharedInstance().accessToken)
        flutterResult = nil
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        flutterResult?(error.debugDescription)
        flutterResult = nil
    }
}
