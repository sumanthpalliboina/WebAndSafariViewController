//
//  WKViewController.swift
//  WebAndSafariViewController
//
//  Created by Palliboina on 04/05/24.
//

import UIKit

import WebKit

class WKViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var goBackRewindBtn: UIBarButtonItem!
    
    @IBOutlet weak var goForwardBtn: UIBarButtonItem!
    
    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtons()
        
        webView.navigationDelegate = self
        
        if let webURL = URL(string: "https://www.google.com") {
            let urlRequest = URLRequest(url: webURL)
            webView.load(urlRequest)
        }
        
    }
    
    func updateButtons(){
        goBackRewindBtn.isEnabled = webView.canGoBack
        goForwardBtn.isEnabled = webView.canGoForward
    }
    

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if webView.isLoading {
            updateButtons()
        }
        decisionHandler(.allow)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
