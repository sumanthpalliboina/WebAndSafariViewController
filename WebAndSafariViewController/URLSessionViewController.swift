//
//  URLSessionViewController.swift
//  WebAndSafariViewController
//
//  Created by Palliboina on 05/05/24.
//

import UIKit

class URLSessionViewController: UIViewController,URLSessionTaskDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task(priority: .high){
            await loadWebsite()
        }
    }
    
    func loadWebsite() async {
        //let session = URLSession.shared
        
        var config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        
        let webURL = URL(string: "https://www.yahoo.com")
        
        do{
            let (data,response) = try await session.data(from: webURL!,delegate: self)
            if let resp = response as? HTTPURLResponse {
                let status = resp.statusCode
                if status == 200 {
                    let content = String(data: data, encoding: String.Encoding.ascii)
                    print(content!)
                }else{
                    print("Error: \(status)")
                }
            }
        }catch {
            print("Error: \(error)")
        }
    }
    

    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest) async -> URLRequest? {   //every time server asks redirection, we return new request url, it repeats 
        return request
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
