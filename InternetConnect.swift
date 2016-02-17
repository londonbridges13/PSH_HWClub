//
//  InternetConnect.swift
//  Dac
//
//  Created by Lyndon Samual McKay on 2/16/16.
//  Copyright © 2016 Lyndon Samual McKay. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            print("data \(data)")
            print("response \(response)")
            print("error \(error)")
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print("httpResponse.statusCode \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    Status = true
                }
            }
            
        }).resume()
        
        
        return Status
    }
}