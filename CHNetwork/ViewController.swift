//
//  ViewController.swift
//  ChtarNetwork
//
//  Created by Ragaie alfy on 3/11/18.
//  Copyright © 2018 Ragaie alfy. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,CHNetworkDelegate{
    func responseCallBack(result: AnyObject, response: URLResponse, error: Error) {
        print("welcome to test ")
    }
    
  

    @IBOutlet weak var imageViewShow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        CHNetwork.shared.requestData(requestWay: .GET, urlString: "", Loader: true) { (data, reponse, error) in
            
            
        }
        
        
        CHNetwork.shared.requestJson(requestWay: .POST, urlString: "", Loader: true) { (result, respone, error) in
            
            
        }
  
        CHNetwork.shared.requestData(requestWay: .GET, urlString: "", Loader: true, flage: "requestCurrentData", delegate: self)
        
        CHNetwork.shared.requestJson(requestWay: .POST, urlString: "", Loader: false, flage: "countriesdata", delegate: self)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        CHNetwork.shared.renderImageWith(urlString: "https://www.cheatsheet.com/wp-content/uploads/2017/05/Puppy-basset-at-the-beach.jpg", imageView: imageViewShow, placeHolderImageName: "placeholder.png")
        
        
        
        
    }

    
    
    @IBAction func showloader(_ sender: Any) {
        CHNetwork.shared.LoaderIndicator.startAnimate()
    }
    
    
    
    @IBAction func hideLoader(_ sender: Any) {
        CHNetwork.shared.LoaderIndicator.stopAnimate()

        
    }
    
    
    
    
    
}

