RSNetworking
=====================
RSNetworking is the start of a networking library written entirly for the Swift programming language.  In it's current state, I would strongly recommend not using it in a production environment as I have just started developing and testing it.  There will be major changes that occur (hopefully) very quickly.  I am hopeful that others will begin to assist in the development effort and we will be able to create an awesome networking library in the Swift programming language. 

------------

## Classes

###RSTransaction  

RSTransaction is the class that defines the transaction we wish to make.  It exposes four properties, one initiator and one method.

#####Properties  

*TransactionType - This defines the HTTP request method.  Currently there are three types, GET, POST, UNKNOWN.  Only the GET and POST actually sends a request.
*baseURL - This is the base URL to use for the request.  This will normally look something like this:  "https://itunes.apple.com".  If you are going to a non-standard port you would put that here as well.  It will look something like this:  "http://mytestserver:8080"
*path - The path that will be added to the base url.  This will normally be something like this: "search".  It can also include a longer path string like: "path/to/my/service"
*parameters - Any parameters to send to the service.

#####initiators

*init(transactionType: RSTransactionType, baseURL: String,  path: String, parameters: [String: String]) - This will initialize the RSTransaction with all properties needed.

#####Functions  

*getFullURLString() -> String - Builds and returns the full URL needed to connect to the service.


###RSTransactionRequest  

RSTransactionRequest is the class that builds and send out the request to the service defined by the RSTransaction.  It exposes four functions.  

#####Functions  

*func dataFromRSTransaction(transaction: RSTransaction, completionHandler handler: RSNetworking.dataFromRSTransactionCompletionCompletionClosure):  Retrieves an NSData object from the service defined by the RSTransaction.  This is the main function and is used by the other three functions to retrieve an NSData object prior to converting it to the required format.

*func stringFromRSTransaction(transaction: RSTransaction, completionHandler handler:  RSNetworking.stringFromRSTransactionCompletionCompletionClosure):  Retrieves an NSString object from the service defined by the RSTransaction.  This function uses the dataFromRSTransaction function to retrieve an NSData object and then converts it to an NSString object.

*func dictionaryFromRSTransaction(transaction: RSTransaction, completionHandler handler:  RSNetworking.dictionaryFromRSTransactionCompletionCompletionClosure):  Retrieves an NSDictionary object from the service defined by the RSTransaction.  This function uses the dataFromRSTransaction function to retrieve an NSData object and then converts it to an NSDictionary object.  The data returned from the URL should be in JSON format for this function to work properly.

*func imageFromRSTransaction(transaction: RSTransaction, completionHandler handler:  RSNetworking.imageFromRSTransactionCompletionCompletionClosure):  Retrieves an UIImage object from the service defined by the RSTransaction.  This function uses the dataFromRSTransaction function to retrieve an NSData object and then converts it to an UIImage object.

###RSURLRequest  

RSURLRequest will send a GET request to a service with just a URL.  There is no need to defince a RSTransaction to use this class.  RSURLRequest exposes four functions.  

#####Functions  

*func dataFromURL(url: NSURL, completionHandler handler: RSNetworking.dataFromURLCompletionClosure):  Retrieves an NSData object from the URL passed in.  This is the main function and is used by the other three functions to retrieve an NSData object prior to converting it to the required format

*func stringFromURL(url: NSURL, completionHandler handler:  RSNetworking.stringFromURLCompletionClosure):  Retrieves an NSString object from the URL passed in.  This function uses the dataFromURL function to retrieve an NSData object and then converts it to an NSString object.

*func dictionaryFromJsonURL(url: NSURL, completionHandler handler:  RSNetworking.dictionaryFromURLCompletionClosure):  Retrieves an NSDictionary object from the URL passed in.  This function uses the dataFromURL function to retrieve an NSData object and then converts it to an NSDictionary object.  The data returned from the URL should be in JSON format for this function to work properly.

*func imageFromURL(url: NSURL, completionHandler handler:  RSNetworking.imageFromURLCompletionClosure):  Retrieves an UIImage object from the URL.  This function uses the dataFromURL function to retrieve an NSData object and then converts it to an UIImage object.

###RSUtilities  

RSUtilities will contain various utilities that do not have their own class.  Currently there is only one function exposed by this class

#####Functions  

*func isHostnameReachable(hostname: NSString) -> Bool - This function will check to see if a host is available or not.  This is a class function.

###RSNetworking - Depreciated  
 
This class will be removed in the near future and should not be used.


## Extensions

Here is a list of extensions provided

* UIImageView
     - setImageForURL(url: NSString, placeHolder: UIImage):  Sets the image in the UIImageView to the placeHolder image and then asynchronously downloads the image from the URL.  Once the image is downloaded it then replaces the placeHolder image with the image downloaded.
     - setImageForURL(url: NSString):  Asynchronously downloads the image from the URL.  Once the image is downloaded, it sets the image of the UIImageView to the downloaded image.

-------------


Sample code for Networking Library

##RSURLRequest

#### dataFromURL
```
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
```
        
#### dictionaryFromJsonURL
```
        var client = Client()
        
        var testURL = NSURL.URLWithString("https://itunes.apple.com/search?term=jimmy+buffett&media=music")
        
        client.dictionaryFromJsonURL(testURL, completionHandler: {(response : NSURLResponse!, responseDictionary: NSDictionary!, error: NSError!) -> Void in
            if !error? {
                println("Response Dictionary: \(responseDictionary)")
            } else {
                println("Error : \(error)")
            }
            })
```

#### stringFromURL  
```     
        var client = Client()
        
        var testURL = NSURL.URLWithString("https://itunes.apple.com/search?term=jimmy+buffett&media=music")
        
        client.stringFromURL(testURL, completionHandler: {(response : NSURLResponse!, responseString: NSString!, error: NSError!) -> Void in
            if !error? {
            	println("Response Data: \(responseString)")
            } else {
                println("Error : \(error)")
            }
            })
```
 
#### imageFromURL  
```         
        var client = Client()  
          
        var imageURL = NSURL.URLWithString("http://a1.mzstatic.com/us/r30/Music/y2003/m12/d17/h16/s05.whogqrwc.100x100-75.jpg")
        
        client.imageFromURL(imageURL, completionHandler: {(response : NSURLResponse!, image: UIImage!, error: NSError!) -> Void in
            if !error? {
            	self.imageView.image = image;
            } else {
              println("Error : \(error)")
            }
            })
```

#### RSUtilities.isHostnameReachable
```
				var client = RSNetworking()
        if (client.isHostnameReachable("www.apple.com")) {
            println("reachable")
        } else {
            println("Not Reachable")
        }
```
        
#### UIImageView:  setImageForURL
```
				imageView.setImageForURL(imageURL, placeHolder: UIImage(named: "loading"))	
				
				or
				
				imageView.setImageForURL(imageURL)	
```



###RSTransactionRequest  

####dictionaryFromRSTransaction
```
		var rsRequest = RSTransactionRequest()
		
		var rsTransGet = RSTransaction(transactionType: RSTransactionType.GET, baseURL: "https://itunes.apple.com", path: "search", parameters: ["term":"jimmy+buffett","media":"music"])
		
		rsRequest.dictionaryFromRSTransaction(rsTransGet, completionHandler: {(response : NSURLResponse!, responseDictionary: NSDictionary!, error: NSError!) -> Void in
            if !error? {
                println(responseDictionary)
            } else {
                //If there was an error, log it
                println("Error : \(error)")
            }
            })
```            

Now that you have the RSTransaction, you can simply change the parameters and make another request, if needed, like this:
```
		rsTransGet.parameters = ["term":"jimmy","media":"music"]
		
		rsRequest.dictionaryFromRSTransaction(rsTransGet, completionHandler: {(response : NSURLResponse!, responseDictionary: NSDictionary!, error: NSError!) -> Void in
            if !error? {
                println(responseDictionary)
            } else {
                //If there was an error, log it
                println("Error : \(error)")
            }
            })
```

####stringFromRSTransaction
```
		var RSRequest = RSTransactionRequest()
		
		var RSTransGet = RSTransaction(transactionType: RSTransactionType.GET, baseURL: "https://itunes.apple.com", path: "search", parameters: ["term":"jimmy+buffett","media":"music"])
		
		RSRequest.stringFromRSTransaction(RSTransGet, completionHandler: {(response : NSURLResponse!, responseDictionary: NSDictionary!, error: NSError!) -> Void in
            if !error? {
                println(responseDictionary)
            } else {
                //If there was an error, log it
                println("Error : \(error)")
            }
            })
``` 

