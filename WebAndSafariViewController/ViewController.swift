//
//  ViewController.swift
//  WebAndSafariViewController
//
//  Created by Palliboina on 04/05/24.
//

import UIKit

import SafariServices

class ViewController: UIViewController,SFSafariViewControllerDelegate {

    @IBOutlet weak var openInExternalBtn: UIButton!
    
    @IBOutlet weak var openInOurApp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func openLinkInBrowser(_ sender: UIButton) {
        let urlString = "http://www.formasterminds.com"
        
      /*  ///method1:
        if let webURL = URL(string: urlString) {
            Task(priority:.high){
                await openURL(url:webURL)
            }
        }
      */
        
        ///method2:
        if let data = urlString.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            if let webURL = URL(dataRepresentation: data, relativeTo: nil, isAbsolute: true) {
                Task(priority:.high){
                    await openURL(url:webURL)
                }
            }
        }
    }
    
    func openURL(url:URL) async {
        let scene = view.window?.windowScene
        await scene?.open(url, options: nil)
    }
    
    
    @IBAction func openInOurApp(_ sender: UIButton) {
        let urlString = "http://www.formasterminds.com"
        let webURL = URL(string: urlString)
        
        var config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = false  //preventing bar collapsing while scrolling
        
        let safariController = SFSafariViewController(url: webURL!,configuration: config)
        safariController.delegate = self
        safariController.dismissButtonStyle = .close
        ///safariController.preferredBarTintColor = UIColor(red: 91/255, green: 81/255, blue: 119/255, alpha: 1.0)
        safariController.preferredBarTintColor = .lightGray
        safariController.preferredControlTintColor = .systemRed
        present(safariController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("closed")
        openInOurApp.isEnabled = false  //disable button after user closed scene of controller
    }
    
}

