//
//  ZJJSBridgeHandler.swift
//  WKWebViewUse
//
//  Created by 张君君 on 2021/2/7.
//

/// oc调用js相关回调
typealias ZJCllJSResponse = (Any?,Error?)->(Void)

import UIKit
import WebKit

class ZJJSBridgeHandler: NSObject, WKScriptMessageHandler {
    
    var jsMethodsName:Set<String>? = Set()
    weak var delegate:ZJJSBridgeHandlerDelegate?
    private weak var webView:WKWebView?
    
    public class func  initWithWebView(_ webView:WKWebView) -> ZJJSBridgeHandler {
        let bridgeHandler = ZJJSBridgeHandler()
        weak var weakWebView = webView
        bridgeHandler.webView = weakWebView
        return bridgeHandler
    }
    
    
    /// 添加单个JS交互
    /// - Parameter name: js交互名
    public  func addJSName(_ name:String)  {
        self.jsMethodsName?.insert(name)
        addJSMethodsScript()
    }
    
    
    /// 添加一组JS交互
    /// - Parameter names: js交互名集合
    public func addJSNames(_ names:[String]) {
        for name in names {
            self.jsMethodsName?.insert(name)
        }
        addJSMethodsScript()
    }
    
    public func callJS(_ jsName:String?,_ params:String?,_ result: ZJCllJSResponse?) {
        weak var weakSelf = self
        guard let _ = jsName else {
            return
        }
        var jsScript = jsName!
        if params != nil && params!.count > 0 {
            jsScript = "\(jsName!)('\(params!)')"
        }
        DispatchQueue.main.async {
            weakSelf!.webView?.evaluateJavaScript(jsScript, completionHandler: result)
        }
    }
    
    public func removeAllScript()  {
        guard let _ = jsMethodsName else { return  }
        weak var weakSelf = self
        for name  in self.jsMethodsName! {
            weakSelf!.webView?.configuration.userContentController.removeScriptMessageHandler(forName: name)
        }
    }
    
    
    ///注入js交互
    func addJSMethodsScript()  {
        weak var weakSelf = self
        guard let _ = jsMethodsName else { return  }
        
        DispatchQueue.main.async {
            for name  in self.jsMethodsName! {
                weakSelf!.webView?.configuration.userContentController.removeScriptMessageHandler(forName: name)
                weakSelf!.webView?.configuration.userContentController.add(weakSelf!, name: name)
            }
            
        }
    }
    
    deinit {
        print("ZJJSBridgeHandler_deinit\(self)")
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        weak var weakSelf = self
        self.delegate?.jsEvent?(name: message.name, body: message.body, bridge: weakSelf!)
    }
    
    
}
