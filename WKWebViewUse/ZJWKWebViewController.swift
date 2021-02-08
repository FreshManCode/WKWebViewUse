//
//  ZJWKWebViewController.swift
//  WKWebViewUse
//
//  Created by 张君君 on 2021/2/7.
//

import UIKit
import WebKit

class ZJWKWebViewController: UIViewController,WKNavigationDelegate, WKUIDelegate,ZJJSBridgeHandlerDelegate {
    @IBOutlet weak var webview: WKWebView!
    
    var configuratuon:WKWebViewConfiguration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WebView"
        loadWebView()
    }


    func loadWebView()  {
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        
        configuratuon = WKWebViewConfiguration()
        let userController = WKUserContentController()
        configuratuon?.userContentController = userController
        let webviewPath = Bundle.main.path(forResource: "WKWebView", ofType: "html")
        guard let _ = webviewPath else { return  }
        let request = NSURLRequest.init(url: URL.init(fileURLWithPath: webviewPath!))
        webview.load(request as URLRequest)
    }
    
    
    /// 调用js函数,弹窗
    /// - Parameter sender: ...
    @IBAction func addAlert(_ sender: Any) {
        jsBridgeHander?.callJS("ocCallMethod", "Hello body") { (res, error) -> (Void) in
            print("res is:\(res),error is:\(error)")
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController.init(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
            completionHandler()
        }))
        present(alertController, animated: true, completion: nil)
        
    }
    
    func addJSMessageHandler()  {
        jsBridgeHander?.addJSName("testMethodOne")
        jsBridgeHander?.addJSNames(["changeColor","submit"])
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        addJSMessageHandler()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
    }
    
    
    deinit {
//       移除所有脚本
        jsBridgeHander?.removeAllScript()
        print("self deinit:\(self)")
    }
    
    
    // MARK: - ZJJSBridgeHandlerDelegate

    func jsEvent(name: String, body: Any, bridge: ZJJSBridgeHandler) {
       print("name is:\(name),body is:\(body)")
    }
    
    lazy var jsBridgeHander:ZJJSBridgeHandler? = {
        let bridge = ZJJSBridgeHandler.initWithWebView(self.webview)
        bridge.delegate = self
        return bridge
    }()
}
