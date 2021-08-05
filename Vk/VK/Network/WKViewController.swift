//
//  WKViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 20.04.2021.
//

import UIKit
import WebKit

class WKViewController: UIViewController {
    
    var tokenVK: String?
    var mapping = NetworkManager()
    struct AuthScope: OptionSet {
        let rawValue: Int

        static let friend    = AuthScope(rawValue: 1 << 1)
        static let photos  = AuthScope(rawValue: 1 << 2)
        static let wall   = AuthScope(rawValue: 1 << 13)
        static let offline   = AuthScope(rawValue: 1 << 16)
        static let groups   = AuthScope(rawValue: 1 << 18)

        static let all: AuthScope = [.friend, .photos, .wall, .offline, .groups]
    }

    

    
    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAuth()
    }
    
    private func configureAuth() {
        
        var urlComponenets = URLComponents()
        urlComponenets.scheme = "http"
        urlComponenets.host = "oauth.vk.com"
        urlComponenets.path = "/authorize"
        urlComponenets.queryItems = [
            URLQueryItem(name: "client_id", value: "7831130"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//            URLQueryItem(name: "scope", value: "401502"),
            URLQueryItem(name: "scope", value: "\(AuthScope.all.rawValue)"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponenets.url!)
        
        webView.load(request)
    }
}

extension WKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        tokenVK = params["access_token"]
        Sessions.shared.token = tokenVK ?? ""        
        
//        print("Access Token: \(tokenVK)")
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "go", sender: self)
        
    }
}
