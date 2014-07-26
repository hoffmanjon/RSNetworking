//
//  ViewController.swift
//  RSNetworkSample
//
//  Created by Jon Hoffman on 7/13/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var appsTableView : UITableView!
    var tableData: NSArray = NSArray()
    
    //execute this function when the view loads.
    //This function will execute the iTunes search and upon return will execute the block of code
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Initiate the RSNetworking library and create the URL

        if (RSUtilities.isHostnameReachable("www.apple.com")) {
            println("reachable")
        } else {
            println("Not Reachable")
        }
        
        //initilate the RSTransactionRequest()
        var rsRequest = RSTransactionRequest()
        
        //Load top image
        imageView.setImageForURL("http://4.bp.blogspot.com/-PVYkrTJ3Agg/U4NDUROnA4I/AAAAAAAACm8/CnvhLkaX50U/s1600/rover_side.jpg");
        
       //Define a RSTranaction object
        var rsTransGet = RSTransaction(transactionType: RSTransactionType.GET, baseURL: "https://itunes.apple.com", path: "search", parameters: ["term":"jimmy+buffett","media":"music"])
        
    
        //Call the dictionaryFromRSTransaction function to make the request to the iTunes search API
        rsRequest.dictionaryFromRSTransaction(rsTransGet, completionHandler: {(response : NSURLResponse!, responseDictionary: NSDictionary!, error: NSError!) -> Void in
            if !error? {
                //Set the tableData NSArray to the results that were returned from the iTunes search and reload the table
                self.tableData = responseDictionary["results"] as NSArray
          //      println(responseDictionary)
                self.appsTableView.reloadData()
            } else {
                //If there was an error, log it
                println("Error : \(error)")
            }
            })
        
        
        //Post request
        var rsTransPost = RSTransaction(transactionType: RSTransactionType.POST, baseURL: "https://posttestserver.com", path: "post.php", parameters: ["term":"jimmy+buffett","media":"music"])
        
        //Call the stringFromRSTrasaction function to make the request to posttestserver.com
        rsRequest.stringFromRSTransaction(rsTransPost, completionHandler: {(response : NSURLResponse!, responseString: NSString!, error: NSError!) -> Void in
            if !error? {
                //Log response string
                println(responseString)
            } else {
                //If there was an error, log it
                println("Error : \(error)")
            }
            }) 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableView delegate methods are below:
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let kCellIdentifier: String = "MyCell"
        
        //tablecell optional to see if we can reuse cell
        var cell : UITableViewCell?
        cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell
        
        //If we did not get a reuseable cell, then create a new one
        if !cell? {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: kCellIdentifier)
        }
        
        //Get our data row
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        //Set the text and add a blank image
        let cellText: String? = rowData["trackName"] as? String
        
        cell!.textLabel.text =  cellText
        
        // Get the track censoredName
        var trackCensorName: NSString = rowData["trackCensoredName"] as NSString
        cell!.detailTextLabel.text = trackCensorName
        
        // Grab the artworkUrl60 key to get an image URL
        var imageURL: NSString = rowData["artworkUrl60"] as NSString
        var mCell = cell
        mCell!.imageView.setImageForURL(imageURL, placeHolder: UIImage(named: "loading"))
        
        return cell
        
    }
    
    
    
}