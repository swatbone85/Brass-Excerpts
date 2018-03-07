//
//  DetailViewController.swift
//  Brass Excerpts
//
//  Created by Thomas Swatland on 03/12/2017.
//  Copyright © 2017 Thomas Swatland. All rights reserved.
//

import UIKit
import WebKit
import FirebaseStorage
import NVActivityIndicatorView

class DetailViewController: UIViewController {
    
    var storage = Storage()
    var instrument = String()
    var filePath = String()
    
    let container = ActivityIndicator.container
    let activityIndicator = ActivityIndicator.activityIndicator
    
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        loadPDF()
    }

    @IBAction func shareButtonPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [(webView.url)! as URL], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)

    }
    
    func setupWebView() {
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    func loadPDF() {
        
        showActivityIndicator()
        storage = Storage.storage()
        let fileRef = storage.reference().child(instrument).child(filePath)
        
        fileRef.downloadURL { url, err in
            if err != nil {
                let alert = UIAlertController(title: "Alert", message: "File not found!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                guard let url = url else { return }
                let urlRequest = URLRequest(url: url)
                self.webView.load(urlRequest)
            }
        }
    }
    
    func showActivityIndicator() {
        
        container.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 - 100)
        container.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        container.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        activityIndicator.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height / 2)
        
        ActivityIndicator.start()
        
        container.addSubview(activityIndicator)
        webView.addSubview(container)
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.stop()
        container.removeFromSuperview()
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityIndicator()
    }
}

