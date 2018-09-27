//
//  ChtarSupport.swift
//  ChtarNetwork
//
//  Created by Ragaie alfy on 3/11/18.
//  Copyright © 2018 Ragaie alfy. All rights reserved.
//

import Foundation
public enum HTTPWay : String{
    case GET = "GET"
    case POST = "POST"
    
}


public enum CHLoaderType : String{
    case Default = "Default"
    case Normal = "Nloader"
    case Football = "Floader"
    case Rocket = "Rloader"
    case Shopping = "SLoader"
    case Circle = "Cloader"
    case FlightPlane = "Flightloader"
    case Arial = "Arialloader"
    
}

public protocol CHNetworkDelegate{
    
    func responseCallBack(result : AnyObject, response : URLResponse,error : Error,flage : String)
    
    
}
