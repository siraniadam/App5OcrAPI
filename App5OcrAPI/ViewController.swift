//
//  ViewController.swift
//  App5OcrAPI
//
//  Created by Nadia Mettioui on 23/04/2020.
//  Copyright © 2020 Nadia Mettioui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL
        let url = URL(string: "https://ocr-text-extractor.p.rapidapi.com/detect-text-from-image-uri")
        
        guard url !=  nil else {
            print("Error creating url object")
            return
        }
        
        // URL Request
        var  request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        
        //Specify the header
        
        let header = [
            "x-rapidapi-host": "ocr-text-extractor.p.rapidapi.com",
            "x-rapidapi-key": "72f0df7f1amsh77a4e1a4554c430p1c02c5jsn2ba7085bd18a",
            "accept": "string",
            "content-type": "application/json"
        ]
        
        request.allHTTPHeaderFields = header
        
        // Specifuy the body
        let jsonObject =
           
             [ "Uri": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
              "Language": "eng",
              "DetectOrientation": false,
              "Scale": false,
              "IsTable": false,
              "OcrEngine": "Version2"
                ] as [String : Any] // cast because different Type of data (key : String but value mixed
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
            request.httpBody = requestBody
            }
        catch {
            print(" cerror creating data from json")
        }
    
    // Set the request type
        request.httpMethod = "POST"
        
    // Get the URLSEssion
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // cj-heck for errors
            if error == nil && data != nil {
                //try to parse out data
                do {
                    let dictionary =  try  JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(dictionary) as? [String:Any]
                }
                catch {
                    print("Error parsing response  Data")
                }
                // Fire off the data task
                
            }
            
            
        }
        
        dataTask.resume()
  }
}
