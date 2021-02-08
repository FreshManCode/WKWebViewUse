//
//  ZJJSBridgeHandlerProtocol.swift
//  WKWebViewUse
//
//  Created by 张君君 on 2021/2/7.
//

import Foundation

@objc protocol ZJJSBridgeHandlerDelegate {
    
    
    /// JS调用OC回调
    /// - Parameters:
    ///   - name: 函数名
    ///   - body: 函数体
    ///   - bridge: 对应的桥梁
    @objc optional  func jsEvent(name:String,body:Any,bridge:ZJJSBridgeHandler)
    
}

