//
//  MIWebViewController.swift
//  mobishout
//
//  Created by Diogo Grilo on 30/08/2016.
//  Copyright © 2016 Diogo Grilo. All rights reserved.
//

import UIKit
import WebKit
import QuartzCore

public class MIWebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView = WKWebView(frame: CGRectZero)
    @IBOutlet weak var progressView: UIProgressView!
    var activityIndicator: UIActivityIndicatorView?
    var viewTitle:String?
    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!
    var urlString = ""
    var addMenuButton = true
    
    init(urlString:String, addMenuButton:Bool = true) {
        super.init(nibName: "MIWebViewController", bundle: nil)
        self.urlString = urlString
        self.addMenuButton = addMenuButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTitle = self.title

        self.webView.navigationDelegate = self
        self.view.insertSubview(self.webView, belowSubview: self.progressView)
        self.webView.frame = self.view.bounds
        self.webView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        self.progressView.progressTintColor = MIConstants.Colors.blue
        self.progressView.trackTintColor = UIColor(white: 0, alpha: 0.2)
        
        self.progressView.hidden = false
        self.progressView.setProgress(0, animated: false)
        
        self.navigationItem.titleView = UIView(frame: CGRectMake(0, 0, 40, 40))
        self.addActivityIndicator(UIColor.whiteColor(), inView:self.navigationItem.titleView!)
        
        self.backButton = UIBarButtonItem(title: "⟨", style: .Plain, target: self, action: #selector(self.back(_:)))
        self.forwardButton = UIBarButtonItem(title: "⟩", style: .Plain, target: self, action: #selector(self.forward(_:)))
        self.backButton.enabled = false
        self.forwardButton.enabled = false
        self.navigationItem.rightBarButtonItems = [self.forwardButton, self.backButton]
        
        if let url = NSURL(string: self.urlString) {
            let request = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
        }
    }
    
    func back(sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    
    func forward(sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    
    func reload(sender: UIBarButtonItem) {
        let request = NSURLRequest(URL:self.webView.URL!)
        self.webView.loadRequest(request)
        self.navigationItem.titleView = UIView(frame: CGRectMake(0, 0, 40, 40))
        self.addActivityIndicator(UIColor.whiteColor(), inView:self.navigationItem.titleView!)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<()>) {
        if (keyPath == "loading") {
            backButton.enabled = webView.canGoBack
            forwardButton.enabled = webView.canGoForward
        }
        if (keyPath == "estimatedProgress") {
            progressView.hidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
        self.viewTitle = webView.title
        self.removeActivityIndicator()
    }
    
    /*func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request.URL?.scheme)
        if (navigationType == .LinkClicked) {
            
            if (request.URL?.scheme == "http" || request.URL?.scheme == "https") {
                if let url = request.URL {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            
            return false
        }
        return true
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.webView.removeObserver(self, forKeyPath: "loading", context: nil)
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }

    override func viewWillAppear(animated: Bool) {
        self.webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }
    func addActivityIndicator(color:UIColor! = MIConstants.Colors.smiityBlue, inView:UIView? = nil){
        let targetView:UIView = inView ?? self.view
        if self.activityIndicator == nil {
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            self.activityIndicator?.backgroundColor = UIColor.clearColor()
            self.activityIndicator?.frame = targetView.bounds
            self.activityIndicator?.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
            self.activityIndicator?.hidesWhenStopped = true
            self.activityIndicator?.color = color
            self.activityIndicator?.startAnimating()
        }
        UIView.animateWithDuration(0.25) { 
            self.activityIndicator?.alpha = 1
        }
        targetView.addSubview(self.activityIndicator!)
    }
    func removeActivityIndicator(){
        if self.activityIndicator != nil {
            UIView.animateWithDuration(0.25, animations: { 
                self.activityIndicator?.alpha = 0
                }, completion: { (finished) in
                    self.activityIndicator!.stopAnimating()
                    self.activityIndicator!.removeFromSuperview()
                    self.activityIndicator = nil
                    self.navigationItem.titleView = nil
                    self.title = self.viewTitle
            })
            
        }
    }
}
