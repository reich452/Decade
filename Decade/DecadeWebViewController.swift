//
//  DecadeWebViewController.swift
//  Decade
//
//  Created by Nick Reichard on 5/8/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class DecadeWebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    var decades: [Decade] = []
    var url: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()

    }
    
    func loadWebView() {
        // TODO safly unwrap!
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let url = url, let webView = webView else { print("Can not load url"); return }
        DispatchQueue.main.async {
            webView.loadRequest(URLRequest(url: URL(string: url)!))
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
