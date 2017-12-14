//
//  ViewController.swift
//  Animation
//
//  Created by Slah Layouni on 12/13/17.
//  Copyright © 2017 Layouni. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDownloadDelegate {
    
    let circleProgressBar = CircleProgressBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        circleProgressBar.center = view.center
        circleProgressBar.percentageLabel.textColor = .white
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startDownload)))
        view.addSubview(circleProgressBar)
    }
    
    @objc func startDownload(){
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let stringUrl = "http://ipv4.download.thinkbroadband.com/10MB.zip"
        guard let url = URL(string: stringUrl) else {
            return
        }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            // async
            self.circleProgressBar.progress = Int(CGFloat(totalBytesWritten)/CGFloat(totalBytesExpectedToWrite)*100)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("download finished")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


