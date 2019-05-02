//
//  ServicesViewController.swift
//  NotAccessibleBank
//
//  Created by Anan Sadiya on 15/04/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class ServicesViewController: BaseViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHtmlFile()
    }
    
    private func loadHtmlFile() {
        if let url = Bundle.main.url(forResource: "services", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }
}
