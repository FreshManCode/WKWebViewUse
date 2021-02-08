//
//  ZJRootViewController.swift
//  WKWebViewUse
//
//  Created by 张君君 on 2021/2/7.
//

import UIKit

class ZJRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Root"
    }


    @IBAction func toWebView(_ sender: UIButton) {
        navigationController?.pushViewController(ZJWKWebViewController(), animated: true)
    }
    
}
