//
//  ChtarNetwork.swift
//  ChtarNetwork
//
//  Created by Ragaie alfy on 3/11/18.
//  Copyright © 2018 Ragaie alfy. All rights reserved.
//

import UIKit

open class CHNetwork: NSObject {
     static let shared = CHNetwork()
     var LoaderIndicator : CHLoader!  = CHLoader()
    var headers : [String:String] = [:]
    
    override init() {
        super.init()
    }
   
    
    
 
    
    
//MARK : get data with json reponse.
    open func requestJson(requestWay : HTTPWay,bodyParameter : Data? = nil ,urlString : String,Loader : Bool , result: @escaping (NSDictionary,URLResponse,Error)->Void){
        let url = URL(string:urlString)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = requestWay.rawValue
        
        if bodyParameter != nil {
            
            request.httpBody = bodyParameter
        }
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
       UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if Loader {
            CHNetwork.shared.LoaderIndicator.startAnimate()
        }
        
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
         
            do {
                 let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                DispatchQueue.main.async {
                    result(jsonResult, response!, error!)
                    
                    ///Update ui indecator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if Loader {
                        CHNetwork.shared.LoaderIndicator.stopAnimate()
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    result(NSDictionary(), response!, error)
                    
                    ///Update ui indecator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if Loader {
                        CHNetwork.shared.LoaderIndicator.stopAnimate()
                    }
                }            }
        }
        task.resume()
    }
   
    
    
//MARK : get data with data reponse.
    open func requestData(requestWay : HTTPWay,bodyParameter : Data? = nil ,urlString : String,Loader : Bool , result: @escaping (Data,URLResponse,Error)->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if Loader {
            CHNetwork.shared.LoaderIndicator.startAnimate()
        }
        let url = URL(string:urlString)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = requestWay.rawValue
        if bodyParameter != nil {
            
            request.httpBody = bodyParameter
        }
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                result(data!, response!, error!)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if Loader {
                    CHNetwork.shared.LoaderIndicator.stopAnimate()
                }
            }
           
        }
        task.resume()
    }
    
    
    
    
    //MARK: calling with delegate function
    //MARK : get data with json reponse with delegate .
    open func requestJson(requestWay : HTTPWay,bodyParameter : Data? = nil ,urlString : String,Loader : Bool ,flage : String,delegate : CHNetworkDelegate){
        let url = URL(string:urlString)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = requestWay.rawValue
        
        if bodyParameter != nil {
            
            request.httpBody = bodyParameter
        }
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if Loader {
            CHNetwork.shared.LoaderIndicator.startAnimate()
        }
        
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                DispatchQueue.main.async {
                    delegate.responseCallBack(result: jsonResult, response: response!, error: error!,flage: flage)
                    ///Update ui indecator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if Loader {
                        CHNetwork.shared.LoaderIndicator.stopAnimate()
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    delegate.responseCallBack(result: NSDictionary(), response: response!, error: error, flage: flage)

                    ///Update ui indecator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if Loader {
                        CHNetwork.shared.LoaderIndicator.stopAnimate()
                    }
                }            }
        }
        task.resume()
    }
    
    
    
    //MARK : get data with data reponse.
    open func requestData(requestWay : HTTPWay,bodyParameter : Data? = nil ,urlString : String,Loader : Bool,flage : String,delegate : CHNetworkDelegate){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if Loader {
            CHNetwork.shared.LoaderIndicator.startAnimate()
        }
        let url = URL(string:urlString)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = requestWay.rawValue
        if bodyParameter != nil {
            
            request.httpBody = bodyParameter
        }
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                
                delegate.responseCallBack(result: data as AnyObject, response: response!, error: error!,flage: flage)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if Loader {
                    CHNetwork.shared.LoaderIndicator.stopAnimate()
                }
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    open func renderImageWith(urlString : String,imageView : UIImageView,placeHolderImageName : String){
        let activityondecator = UIActivityIndicatorView.init()
        activityondecator.activityIndicatorViewStyle = .whiteLarge
        activityondecator.color = UIColor.gray
        activityondecator.center = CGPoint.init(x: imageView.frame.width / 2, y: imageView.frame.height / 2)
        activityondecator.startAnimating()
        imageView.addSubview(activityondecator)
       
        URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async() {
                    imageView.image = UIImage.init(named: placeHolderImageName)
                   activityondecator.stopAnimating()
                }
                return
            }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
                activityondecator.stopAnimating()

            }
        }.resume()

    }
    
    
    
    
    open func renderImageWith(urlString : String,imageView : UIImageView){
        let activityondecator = UIActivityIndicatorView.init()
        activityondecator.activityIndicatorViewStyle = .whiteLarge
        activityondecator.color = UIColor.gray
        activityondecator.center = CGPoint.init(x: imageView.frame.width / 2, y: imageView.frame.height / 2)
        activityondecator.startAnimating()
        imageView.addSubview(activityondecator)
        
        URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            if data != nil && error == nil{
                DispatchQueue.main.async() {
                    imageView.image = UIImage(data: data!)
                    activityondecator.stopAnimating()
                }
            }
            }.resume()
        
    }
}
