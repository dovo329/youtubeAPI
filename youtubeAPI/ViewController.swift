//
//  ViewController.swift
//  youtubeAPI
//
//  Created by Douglas Voss on 8/14/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

import UIKit

let kVideoId = "KYVdf5xyD8I"
let baseURL = "https://www.googleapis.com/youtube/v3/videos"
let googleProjectId = "fine-gradient-103823"
let googleProjectNumber = "104439241166"
//let googleAPIKey = "AIzaSyBDTts7_p_IEf1v0sJGGH-t8EfU4B2fCn0"
let googleAPIKey = "AIzaSyDKqdgKxGSqu2pCwdeI3rzgYEMbGpATzuc"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // example: https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=YOUR_API_KEY&part=snippet,contentDetails,statistics,status
        
        queryWithUrlString(baseURL+"?id="+kVideoId+"&key="+googleAPIKey+"&part=snippet,contentDetails,statistics,status")
    }
    
    func queryWithUrlString(urlString : String)
    {
        if let nsUrl = NSURL(string: urlString)
        {
            let session = NSURLSession.sharedSession()
            let dataTask = session.dataTaskWithURL(nsUrl, completionHandler:
                {(data, response, error) -> Void in
                    if error == nil
                    {
                        var jsonError : NSError? = nil
                        let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error:&jsonError)
                        
                        if let jsonObject = jsonObject as? [String:AnyObject]
                        {
                            dispatch_async(
                                dispatch_get_main_queue(),
                                { () -> Void in
                                    println("\(jsonObject)")
                                }
                            )
                            /*if let dictArr = jsonObject["results"] as? NSArray
                            {
                                // update UI is on the main thread
                                dispatch_async(
                                    dispatch_get_main_queue(),
                                    { () -> Void in
                                        for dict in dictArr
                                        {
                                            if let dict = dict as? NSDictionary
                                            {
                                                println("\(dict)")
                                            }
                                        }
                                    }
                                )
                            } else {
                                // update UI is on the main thread
                                dispatch_async(
                                    dispatch_get_main_queue(),
                                    { () -> Void in
                                        alertWithTitle("JSON Array Cast Failed", message: "", dismissText: "Okay", viewController: self)
                                })
                            }*/
                        } else {
                            // no data returned from server
                            dispatch_async(
                                dispatch_get_main_queue(),
                                { () -> Void in
                                    alertWithTitle("No results", message: "", dismissText: "Okay", viewController: self)
                            })
                        }
                    } else {
                        dispatch_async(
                            dispatch_get_main_queue(),
                            { () -> Void in
                                alertWithTitle("NSURLSession Error", message: String(format:"Code %@", error), dismissText: "Okay", viewController: self)
                        })
                    }
            })
            dataTask.resume()
        } else {
            alertWithTitle("NSURL Creation Failed", message: "", dismissText: "Okay", viewController: self)
        }
    }
}
