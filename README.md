RSNetworking
=====================
RSNetworking is the start of a networking library written entirly in the Swift programming language.  In it's current state, I would strongly recommend not using it in a production environment as I have just started developing and testing it.  I am hopeful that others will begin to assist in the development effort and we will be able to create an awesome networking library in the Swift programming language.

------------

## Functions

Here is a list of the four functions that the library currently exposes:
	
* func dataFromURL(url: NSURL, completionHandler handler: RSNetworking.dataFromURLCompletionClosure):  Retrieves an NSData object from the URL passed in.  This is the main function and is used by the other three functions to retrieve an NSData object prior to converting it to the required format
* func stringFromURL(url: NSURL, completionHandler handler:  RSNetworking.stringFromURLCompletionClosure):  Retrieves an NSString object from the URL passed in.  This function uses the dataFromURL function to retrieve an NSData object and then converts it to an NSString object.
*	func dictionaryFromJsonURL(url: NSURL, completionHandler handler:  RSNetworking.dictionaryFromURLCompletionClosure):  Retrieves an NSDictionary object from the URL passed in.  This function uses the dataFromURL function to retrieve an NSData object and then converts it to an NSDictionary object.  The data returned from the URL should be in JSON format for this function to work properly.
*	func imageFromURL(url: NSURL, completionHandler handler:  RSNetworking.imageFromURLCompletionClosure):  Retrieves an UIImage object from the URL.  This function uses the dataFromURL function to retrieve an NSData object and then converts it to an UIImage object.
* func isHostReachable(hostname: NSString) -> Bool:  Checks to see if the host is available.

## Extensions

Here is a list of extensions provided

* UIImageView
     - setImageForURL(url: NSString, placeHolder: UIImage):  Sets the image in the UIImageView to the placeHolder image and then asynchronously downloads the image from the URL.  Once the image is downloaded it then replaces the placeHolder image with the image downloaded.

-------------


Sample code for Networking Library

#### dataFromURL
        var client = Client()
        var testURL = NSURL.URLWithString("https://itunes.apple.com/search?term=jimmy+buffett&media=music")
        client.dataFromURL(testURL, completionHandler: {(response : NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
            if !error? {
            	var string = NSString(data: responseData, encoding: NSUTF8StringEncoding)
            	println("Response Data: \(string)")
            } else {
                println("Error : \(error)")
            }
            }) 
        
#### dictionaryFromJsonURL
        var client = Client()
        var testURL = NSURL.URLWithString("https://itunes.apple.com/search?term=jimmy+buffett&media=music")
        client.dictionaryFromJsonURL(testURL, completionHandler: {(response : NSURLResponse!, responseDictionary: NSDictionary!, error: NSError!) -> Void in
            if !error? {
                println("Response Dictionary: \(responseDictionary)")
            } else {
                println("Error : \(error)")
            }
            })

#### stringFromURL       
        var client = Client()
        var testURL = NSURL.URLWithString("https://itunes.apple.com/search?term=jimmy+buffett&media=music")
        client.stringFromURL(testURL, completionHandler: {(response : NSURLResponse!, responseString: NSString!, error: NSError!) -> Void in
            if !error? {
            	println("Response Data: \(responseString)")
            } else {
                println("Error : \(error)")
            }
            })
 
#### imageFromURL           
        var client = Client()    
        var imageURL = NSURL.URLWithString("http://a1.mzstatic.com/us/r30/Music/y2003/m12/d17/h16/s05.whogqrwc.100x100-75.jpg")
        client.imageFromURL(imageURL, completionHandler: {(response : NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            if !error? {
            	self.imageView.image = image;
            } else {
              println("Error : \(error)")
            }
            })

#### isHostnameReachable
				var client = RSNetworking()
        if (client.isHostnameReachable("www.apple.com")) {
            println("reachable")
        } else {
            println("Not Reachable")
        }
        
#### UIImageView:  setImageForURL
				imageView.setImageForURL(imageURL, placeHolder: UIImage(named: "loading"))	
				
				or
				
				imageView.setImageForURL(imageURL)	