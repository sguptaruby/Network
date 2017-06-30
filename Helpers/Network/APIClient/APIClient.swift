//
//  APIClient.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]

typealias JSONParams = [String: AnyHashable]

typealias CompletionBlock = (Any?, URLResponse?, Error?) -> Void

fileprivate final class ReachabilityWrapper: NSObject {
    
    /// Shared reachability instance across the app.
    static let sharedReach = Reachability()
    private override init() {}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

fileprivate enum HttpMethods: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
}

struct Admin {
    static let username:String = "uCashAdmin"
    static let password:String = "654321"
}

class APIClient: NSObject {
    
    /// Comletion block to execute on completion of api call.
    private var completionHandler: CompletionBlock?
    
    
    /// File upload request
    ///
    /// - Parameters:
    ///   - params: Parameters to send along with the file data.
    ///   - _urlString: URL for service.
    ///   - _filePath: Full path of the file to upload
    ///   - requestCompletion: Code block to execure when request finishes.
    func uploadRequest(with params: JSONParams, url _urlString: String, imageData: NSData?, completion requestCompletion: CompletionBlock?) {
        let reachabilityStatus = ReachabilityWrapper.sharedReach!.currentReachabilityStatus
        if reachabilityStatus == Reachability.NetworkStatus.notReachable {
            let errorObj: JSONDictionary = ["status": false, "message": "Check your internet connection"]
            if let completion = requestCompletion {
                completion(errorObj, nil, nil)
                return
            }
        }
        
        guard let _url = URL.init(string: _urlString) else {
            return
        }
        
        var bodyData = Data()
        
        var request = URLRequest(url: _url)
        request.httpMethod = HttpMethods.post.rawValue
        let boundary = "0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo"
        let headerBoundary = "multipart/form-data; boundary=" + boundary
        request.addValue(headerBoundary, forHTTPHeaderField: "Content-Type")
        
        let loginString = String(format: "%@:%@", Admin.username, Admin.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let authString = "Basic \(base64LoginString)"
        request.allHTTPHeaderFields = ["authorization" : authString]
        request.addValue(UCashManager.share.login.data.authToken, forHTTPHeaderField: "auth_token")
        request.addValue(UCashManager.share.login.data.merchantId.toString, forHTTPHeaderField: "merchant_id")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        completionHandler = requestCompletion
        
        // Message part
        for (key, value) in params {
            let strValue = String(describing: value)
            let bound = "--\(boundary)\r\n"
            bodyData.append(bound.data(using: String.Encoding.utf8)!)
            
            let fieldName = "Content-Disposition: form-data; name=" + key + "\r\n\r\n"
            bodyData.append(fieldName.data(using: String.Encoding.utf8)!)
            
            bodyData.append(strValue.data(using: String.Encoding.utf8)!)
            bodyData.append("\r\n".data(using: String.Encoding.utf8)!)
        }
        
        if let imgData = imageData {
                    // media part
                    let bounString = "--\(boundary)\r\n"
                    bodyData.append("--\r\n".data(using: String.Encoding.utf8)!)
                    bodyData.append(bounString.data(using: String.Encoding.utf8)!)
                    
                    //let ext = _fPath.components(separatedBy: ".").last
                    let fileName = UUID.init().uuidString + ".jpg"
                    
                    bodyData.append("Content-Disposition: form-data; name=merchant_profile_file_attached; filename=\(fileName)\r\n".data(using: String.Encoding.utf8)!)
                    bodyData.append("Content-Type: image/*\r\n".data(using: String.Encoding.utf8)!)
                    bodyData.append("Content-Transfer-Encoding: binary\r\n\r\n".data(using: String.Encoding.utf8)!)
                    
                    bodyData.append(imgData as Data)
                    bodyData.append("--\r\n".data(using: String.Encoding.utf8)!)
                    bodyData.append(bounString.data(using: String.Encoding.utf8)!)
        }
        
        let randomFilePath = UUID.init().uuidString
        let profileDataPath = filePathInDocDirectory(fileName: randomFilePath)
        let profileDataURL = URL.init(fileURLWithPath: profileDataPath)
        try? bodyData.write(to: profileDataURL)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let uploadTask = session.uploadTask(with: request, fromFile: profileDataURL, completionHandler: { (responseData: Data?, responseObj: URLResponse?, error: Error?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            try? FileManager.default.removeItem(atPath: profileDataPath)
            
            if let completion = self.completionHandler, let d = responseData {
                
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    OperationQueue.main.addOperation {
                        print(jsonObj)
                        completion(jsonObj, responseObj, error)
                    }
                } catch {
                    OperationQueue.main.addOperation {
                        completion(["status": false, "message": error.localizedDescription], responseObj, error)
                    }
                }
            }
        })
        uploadTask.resume()
    }
    
    
    /// POST request
    ///
    /// - Parameters:
    ///   - postParams: parameters to send
    ///   - urlString: Full URL of the service
    ///   - requestCompletion: Code block to execure when request finishes
    func postRequest(withParams postParams: JSONDictionary, url urlString: String, completion requestCompletion: CompletionBlock?) {
        let reachabilityStatus = ReachabilityWrapper.sharedReach!.currentReachabilityStatus
        if reachabilityStatus == Reachability.NetworkStatus.notReachable {
            let errorObj: JSONDictionary = ["status": false, "message": "Check your internet connection"]
            if let completion = requestCompletion {
                completion(errorObj, nil, nil)
                return
            }
        }
        
        let url = URL(string: urlString)!
        let config = URLSessionConfiguration.default
        completionHandler = requestCompletion
        
        let loginString = String(format: "%@:%@", Admin.username, Admin.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
         let session = URLSession(configuration: config)
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post.rawValue
        
        let authString = "Basic \(base64LoginString)"
        request.allHTTPHeaderFields = ["authorization" : authString]
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: postParams)
            let str = String.init(data: jsonData, encoding: String.Encoding.utf8)
            
            debugPrint(url)
            
            debugPrint(str ?? "")
            
            let uploadTask = session.uploadTask(with: request, from: jsonData) { (responseData: Data?, responseObj: URLResponse?, error: Error?) in
                if let completion = self.completionHandler {
                    if let d = responseData {
                        
                        do {
                            let jsonObj = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments)
                            
                            OperationQueue.main.addOperation {
                                print(jsonObj)
                                completion(jsonObj, responseObj, error)
                            }
                        } catch {
                            OperationQueue.main.addOperation {
                                completion(nil, nil, error)
                            }
                        }
                    } else {
                        OperationQueue.main.addOperation {
                            let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                            if let completion = requestCompletion {
                                completion(errorObj, responseObj, error)
                            }
                        }
                    }
                }
            }
            uploadTask.resume()
        } catch {
            fatalError("Request could not be serialized")
        }
    }
    
    /// POST request
    ///
    /// - Parameters:
    ///   - postParams: parameters to send
    ///   - urlString: Full URL of the service
    ///   - requestCompletion: Code block to execure when request finishes
    func postRequestAfterLogin(withParams postParams: JSONDictionary, url urlString: String, completion requestCompletion: CompletionBlock?) {
        let reachabilityStatus = ReachabilityWrapper.sharedReach!.currentReachabilityStatus
        if reachabilityStatus == Reachability.NetworkStatus.notReachable {
            let errorObj: JSONDictionary = ["status": false, "message": "Check your internet connection"]
            if let completion = requestCompletion {
                completion(errorObj, nil, nil)
                return
            }
        }
        
        let url = URL(string: urlString)!
        let config = URLSessionConfiguration.default
        completionHandler = requestCompletion
        
        let loginString = String(format: "%@:%@", Admin.username, Admin.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let session = URLSession(configuration: config)
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post.rawValue
        
        let authString = "Basic \(base64LoginString)"
        request.allHTTPHeaderFields = ["authorization" : authString]
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(UCashManager.share.login.data.authToken, forHTTPHeaderField: "auth_token")
        request.addValue(UCashManager.share.login.data.merchantId.toString, forHTTPHeaderField: "merchant_id")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: postParams)
            let str = String.init(data: jsonData, encoding: String.Encoding.utf8)
            
            debugPrint(url)
            
            debugPrint(str ?? "")
            
            let uploadTask = session.uploadTask(with: request, from: jsonData) { (responseData: Data?, responseObj: URLResponse?, error: Error?) in
                if let completion = self.completionHandler {
                    if let d = responseData {
                        
                        do {
                            let jsonObj = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments)
                            
                            OperationQueue.main.addOperation {
                                print(jsonObj)
                                completion(jsonObj, responseObj, error)
                            }
                        } catch {
                            OperationQueue.main.addOperation {
                                completion(nil, nil, error)
                            }
                        }
                    } else {
                        OperationQueue.main.addOperation {
                            let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                            if let completion = requestCompletion {
                                completion(errorObj, responseObj, error)
                            }
                        }
                    }
                }
            }
            uploadTask.resume()
        } catch {
            fatalError("Request could not be serialized")
        }
    }
    
    /// PUT request
    ///
    /// - Parameters:
    ///   - putParams: parameters to send
    ///   - urlString: Full URL of the service
    ///   - requestCompletion: Code block to execure when request finishes
    func putRequest(withParams postParams: JSONDictionary, url urlString: String, completion requestCompletion: CompletionBlock?) {
        let reachabilityStatus = ReachabilityWrapper.sharedReach!.currentReachabilityStatus
        if reachabilityStatus == Reachability.NetworkStatus.notReachable {
            let errorObj: JSONDictionary = ["status": false, "message": "Check your internet connection"]
            if let completion = requestCompletion {
                completion(errorObj, nil, nil)
                return
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = URL(string: urlString)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        completionHandler = requestCompletion
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.put.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: postParams)
            
            let str = String.init(data: jsonData, encoding: String.Encoding.utf8)
            
            debugPrint(str ?? "")
            
            let uploadTask = session.uploadTask(with: request, from: jsonData) { (responseData: Data?, responseObj: URLResponse?, error: Error?) in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if let completion = self.completionHandler {
                    if let d = responseData {
                        
                        do {
                            let jsonObj = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments)
                            
                            OperationQueue.main.addOperation {
                                print(jsonObj)
                                completion(jsonObj, responseObj, error)
                            }
                        } catch {
                            OperationQueue.main.addOperation {
                                completion(nil, nil, error)
                            }
                        }
                    } else {
                        OperationQueue.main.addOperation {
                            let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                            if let completion = requestCompletion {
                                completion(errorObj, responseObj, error)
                            }
                        }
                    }
                }
            }
            uploadTask.resume()
        } catch {
            fatalError("Request could not be serialized")
        }
    }
    
    /// Delete request
    ///
    /// - Parameters:
    ///   - deleteParams: parameters to send
    ///   - urlString: Full URL of the service
    ///   - requestCompletion: Code block to execure when request finishes
    func deleteRequest(withURL urlString: String, completion requestCompletion: CompletionBlock?) {
        guard let percentEnoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL.init(string: percentEnoded) else { return }
        
        debugPrint(url)
        
        let reachabilityStatus = ReachabilityWrapper.sharedReach!.currentReachabilityStatus
        if reachabilityStatus == Reachability.NetworkStatus.notReachable {
            let errorObj: JSONDictionary = ["status": false, "message": "Check your internet connection"]
            if let completion = requestCompletion {
                completion(errorObj, nil, nil)
                return
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        completionHandler = requestCompletion
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.delete.rawValue
        
        let downloadTask = session.dataTask(with: request) { (responseData: Data?, responseObj: URLResponse?, error: Error?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let completion = self.completionHandler {
                if let d = responseData {
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments) {
                        OperationQueue.main.addOperation {
                            print(jsonObj)
                            completion(jsonObj, responseObj, error)
                        }
                    } else {
                        OperationQueue.main.addOperation {
                            let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                            if let completion = requestCompletion {
                                completion(errorObj, responseObj, error)
                            }
                        }
                    }
                } else {
                    OperationQueue.main.addOperation {
                        let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                        if let completion = requestCompletion {
                            completion(errorObj, responseObj, error)
                        }
                    }
                }
            }
        }
        downloadTask.resume()
    }
    
    /// GET request
    ///
    /// - Parameters:
    ///   - urlString: Full URL of the service
    ///   - requestCompletion: Code block to execure when request finishes
    func getRequest(withURL urlString: String, completion requestCompletion: CompletionBlock?) {
        guard let percentEnoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL.init(string: percentEnoded) else { return }
        
        debugPrint(url)
        
        let reachabilityStatus = ReachabilityWrapper.sharedReach!.currentReachabilityStatus
        if reachabilityStatus == Reachability.NetworkStatus.notReachable {
            let errorObj: JSONDictionary = ["status": false, "message": "Check your internet connection"]
            if let completion = requestCompletion {
                completion(errorObj, nil, nil)
                return
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        completionHandler = requestCompletion
        let loginString = String(format: "%@:%@", Admin.username, Admin.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get.rawValue
        let authString = "Basic \(base64LoginString)"
        request.allHTTPHeaderFields = ["authorization" : authString]
        
        request.addValue(UCashManager.share.login.data.authToken, forHTTPHeaderField: "auth_token")
        request.addValue(UCashManager.share.login.data.merchantId.toString, forHTTPHeaderField: "merchant_id")
        
        let downloadTask = session.dataTask(with: request) { (responseData: Data?, responseObj: URLResponse?, error: Error?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let completion = self.completionHandler {
                if let d = responseData {
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments) {
                        OperationQueue.main.addOperation {
                            print(jsonObj)
                            completion(jsonObj, responseObj, error)
                        }
                    } else {
                        OperationQueue.main.addOperation {
                            let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                            if let completion = requestCompletion {
                                completion(errorObj, responseObj, error)
                            }
                        }
                    }
                } else {
                    OperationQueue.main.addOperation {
                        let errorObj: JSONDictionary = ["status": false, "message": error?.localizedDescription ?? "Something went worong, please try later"]
                        if let completion = requestCompletion {
                            completion(errorObj, responseObj, error)
                        }
                    }
                }
            }
        }
        downloadTask.resume()
    }

    
}
/*
 #import <Foundation/Foundation.h>
 
 NSDictionary *headers = @{ @"content-type": @"application/json",
 @"authorization": @"Basic dUNhc2hBZG1pbjo2NTQzMjE=",
 @"cache-control": @"no-cache",
 @"postman-token": @"0a885e32-8b7a-6b2f-40f5-04d6942ad343" };
 NSDictionary *parameters = @{ @"device_token": @"d5b3a5af4c2170ca4a9903fe1464bf10ff7ec1c5ccc5249c935a1b10d50fdebe",
 @"email": @"amit.sankla@hiteshi.com",
 @"device_id": @"9ED06D1B-A61D-4E7C-A87E-48237D33B765",
 @"password": @"123456",
 @"device_type": @"iPhone" };
 
 NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
 
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ucash.hiteshi.com/api/v1/authentication/login"]
 cachePolicy:NSURLRequestUseProtocolCachePolicy
 timeoutInterval:10.0];
 [request setHTTPMethod:@"POST"];
 [request setAllHTTPHeaderFields:headers];
 [request setHTTPBody:postData];
 
 NSURLSession *session = [NSURLSession sharedSession];
 NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 if (error) {
 NSLog(@"%@", error);
 } else {
 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
 NSLog(@"%@", httpResponse);
 }
 }];
 [dataTask resume];
 */
