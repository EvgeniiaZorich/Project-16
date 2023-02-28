//
//  WikiViewController.swift
//  Project 16
//
//  Created by Евгения Зорич on 01.03.2023.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard url != nil else {
            print("Website not set")
            navigationController?.popViewController(animated: true)
            return
        }
        
        if let url = URL(string: url ?? "https://www.google.com/") {
            webView.load(URLRequest(url: url))
        }
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


