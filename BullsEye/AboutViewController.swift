//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Lucas Almeida on 20/03/19.
//  Copyright © 2019 Lucas Almeida. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadWebView() {
        if let htmlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebView()
    }
}
