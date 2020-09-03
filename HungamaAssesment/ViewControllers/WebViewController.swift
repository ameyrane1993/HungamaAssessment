//
//  WebViewController.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 03/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController {

    @IBOutlet weak var videoWebView: WKWebView!
    var videoKey: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebview(urlString: videoKey)
    }
    
    func loadWebview(urlString: String){
        let url = URL(string: "\(WebServiceMethods.WS_VIDEO_YOUTUBE_URL)\(urlString)")
        if let urlCheck = url{
            let urlReq = URLRequest(url: urlCheck)
            self.videoWebView.load(urlReq)
        }else{
            self.navigationController?.removeFromParent()
        }
    }
}
