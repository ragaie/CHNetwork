//
//  ChtarLoader.swift
//  ChtarNetwork
//
//  Created by Ragaie alfy on 3/13/18.
//  Copyright © 2018 Ragaie alfy. All rights reserved.
//

import UIKit

 class CHLoader: NSObject {
    private var loaderView : UIWebView!
    
    private  var  plurView : UIView!
    private var animate : Bool! = false
    var type : CHLoaderType! = .Default
    
 
    
    override init() {
        super.init()
    }
    
    open func startAnimate(){
      
        if plurView == nil {
            LoaderGif()
            animate = true
        }
        else{
            plurView.isHidden = false
            animate = true
        }
  
    }
    
    
    
    open func stopAnimate(){
        
        plurView.isHidden = true

        //loaderView.isHidden = true
    }
    
    
 
    
    
    
    func LoaderGif(){
        //load file data
      
        let viewHight : CGFloat! =  UIScreen.main.bounds.width / 5
        let viewWidth : CGFloat! =  viewHight//(UIScreen.main.bounds.width / 13) * 8
      
        let cornerValue : CGFloat = 10

        let x = (UIScreen.main.bounds.width / 2) - (viewWidth / 2) //- ( cornerValue / 2)
        let y = (UIScreen.main.bounds.height / 2) - (viewHight / 2)// - ( cornerValue / 2)
        
        loaderView  = UIWebView.init(frame: CGRect.init(x: 3 , y: 3, width: viewWidth - 6, height: viewHight - 6))
        
        plurView = UIView.init(frame: CGRect.init(x: x, y: y, width: viewWidth  , height: viewHight ))
        plurView.backgroundColor = UIColor.white
        plurView.layer.cornerRadius = cornerValue
        
        
   //Arialloader //Flightloader  ,Cloader
        
        let url = Bundle.main.url(forResource: type.rawValue, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        loaderView.layer.cornerRadius = 10
        loaderView.scalesPageToFit = true
        loaderView.contentMode = UIViewContentMode.scaleAspectFit
        loaderView.isUserInteractionEnabled = false
        loaderView.backgroundColor = UIColor.clear
        loaderView.isOpaque = false
        loaderView.allowsInlineMediaPlayback = true
        loaderView.allowsPictureInPictureMediaPlayback = true
        loaderView.allowsLinkPreview = true
        loaderView.load(data, mimeType: "image/gif", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
        
        
        
        plurView.layer.shadowColor = UIColor.gray.cgColor
        plurView.layer.shadowOpacity = 0.7
        plurView.layer.shadowOffset = CGSize.zero
        plurView.addSubview(loaderView)
        
        UIApplication.shared.keyWindow?.addSubview(plurView)
    }
    
    
}
