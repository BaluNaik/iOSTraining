//
//  NetworkWrapper.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class NetworkWrapper: NSObject {
    
    static let sharedInstance = NetworkWrapper()  //singleton class
    
    private var headers:[String: String] = ["x-api-key": ServiceURL.apiKey]
    private var session: URLSession?
    private var sessionConfig = URLSessionConfiguration.default
    
    
    //Because we dont want to allow to create another instance for this class
    private override init() {
        super.init()
        self.sessionConfig.httpAdditionalHeaders = headers   //Passing api key to request
        self.session = URLSession(configuration: self.sessionConfig)
    }
    
    /*
      ================ GET REQUEST  ================
      - This method will take end point(URL), optinal paramets
      - This should be asnyc call
      - After finishing task we have to implement completionHandler
     */
    
    func getRequest(endPoint urlString: String, parameters: [String: Any],
                    sucess: @escaping(_ responseData: Data?) -> Void,
                    fail: @escaping(_ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            
            return
        }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = parameters.map({ (arg) -> URLQueryItem in
            
            return URLQueryItem(name: arg.key, value: "\(arg.value)")
        })
        guard let urlendPoint = urlComponents?.url else {
            
            return
        }
        
        var request = URLRequest(url:urlendPoint)
        request.httpMethod = "GET"          // GET Call
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        //request.httpBody = parameters.description.data(using: String.Encoding.utf8)
        
        let task = session?.dataTask(with: request) { (data, response, error) in
            
            if error != nil || data == nil {
                // failure block
                fail(error)
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    //failure block
                fail(error)
                return
            }
            if let data = data {
                sucess(data)
            }
        }
        task?.resume()
    }
    
    
     /*
         ================ GET REQUEST FOR IMAGE  ================
         - This method will take end point(URL)
         - This should be asnyc call
         - After finishing task we have to implement completionHandler returns image back
        */
    func imageDownloadRequest(endPoint url: URL,
                       sucess: @escaping(_ responseData: Data?) -> Void,
                       fail: @escaping(_ error: Error?) -> Void) {
        let task = session?.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let memType = response?.mimeType, memType.hasPrefix("image"),
            let data = data,
            error == nil else {
                fail(error)
                
                return
            }
            sucess(data)
        }
        task?.resume()
    }
    
    func imageDownloadRequest(endPoint url: URL, params:[String: Any],
                       sucess: @escaping(_ responseData: Data?) -> Void,
                       fail: @escaping(_ error: Error?) -> Void) {
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { //Json --> Data
            return
        }
        request.httpBody = httpBody
        
        let task = session?.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let memType = response?.mimeType, memType.hasPrefix("image"),
            let data = data,
            error == nil else {
                fail(error)
                
                return
            }
            sucess(data)
        }
        task?.resume()
    }
    
    /*
       ================ POST REQUEST  ================
       - This method will take end point(URL), optinal paramets
       - This should be asnyc call
       - After finishing task we have to implement completionHandler
      */
     
    func postRequest(endPoint urlString: String, parameters: [String: Any],
                     sucess: @escaping(_ responseData: Data?) -> Void,
                     fail: @escaping(_ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { //Json --> Data
            return
        }
        request.httpBody = httpBody
        let task = session?.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let data = data,
                error == nil else {
                    fail(error)
                    
                    return
            }
            sucess(data)
        }
        task?.resume()
    }
    
    /*
       ================ DELETE REQUEST  ================
       - This method will take end point(URL), optinal paramets
       - This should be asnyc call
       - After finishing task we have to implement completionHandler
      */
     
    func deleteRequest(endPoint urlString: String, parameters: [String: Any],
                     sucess: @escaping(_ responseData: Data?) -> Void,
                     fail: @escaping(_ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            fail(nil)
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { //Json --> Data
            return
        }
        request.httpBody = httpBody
        let task = session?.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let data = data,
                error == nil else {
                    fail(error)
                    
                    return
            }
            sucess(data)
        }
        task?.resume()
    }
    
    func invokeUploadRequest(endPoint urlString: String, parameters: [String: Any],
                             sucess: @escaping(_ responseData: Data?) -> Void,
                             fail: @escaping(_ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            fail(nil)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        let boundary = "FileUploader-boundary-\(arc4random())-\(arc4random())"
        request.addValue("multipart/form-data;boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let data = NSMutableData()
        for (key, value) in parameters {
            if key == "uploadFile" {
                data.append( "\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                data.append( "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key)\"\r\n".data(using: String.Encoding.utf8)!)
                data.append( "Content-Type: \(key)\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
            }else{
                data.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
            }
        }
        data.append("\r\n--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { //Json --> Data
//            return
//        }
        
        request.httpBody = data as? Data
        let task = session?.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let data = data,
                error == nil else {
                    fail(error)
                    
                    return
            }
            sucess(data)
        }
        task?.resume()
    }
    
    func uploadTask() {
        var request = URLRequest(url: URL(string:"someUrl")!)
        request.httpMethod = "POST"
        let task = session?.uploadTask(with: request, from: Data(), completionHandler: { (data, response, error) in
            
        })
       task?.resume()
        
    }
    
    
    func downlaodTask() {
        var request = URLRequest(url: URL(string:"someUrl")!)
        request.httpMethod = "GET"
        let task = session?.downloadTask(with: request, completionHandler: { (url, response, error) in
            
        })
        task?.resume()
    }
    
}
