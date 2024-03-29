//
//  NetworkManager.swift
//  SJS+ Employee
//
//  Created by Prabaesa Yudha Tama on 20/05/22.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import Network
import SwiftyJSON

/// Helper Class that handle network requests. Uses Alamofire and RxSwift.
class NetworkManager {
    static var shared = NetworkManager()
    
    var header: HTTPHeaders = [:]
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    
    public private(set) var isInternetConnected = false
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.startNetworkMonitoring()
        self.monitor.start(queue: queue)
    }
    
    private func setHeaders() -> HTTPHeaders {
        header = [
            "Authorization": "Basic bmFuYS5udXJ3YW5kYUBnbWFpbC5jb206a2VyamErc2pzKzIwMjE="
        ]
        return header
    }

    /// Handles API Request. Returns Observable with Codable type.
    func APIRequest<T: Codable> (_ methodType: HTTPMethod, encoding: ParameterEncoding = URLEncoding.default, url: String = "", parameters: [String: Any] = [:]) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(url, method: methodType, parameters: parameters, encoding: encoding, headers: self.setHeaders(), interceptor: nil)
                .responseDecodable { (responseData: AFDataResponse<T>) in
                    print("====================")
                    print("URL: \(url)")
                    print("Status: \(String(describing: responseData.response?.statusCode))")
                    print("JSON Response: \(JSON(responseData.data))")
                    
                    switch responseData.result {
                    case .success(let value):
                        if let statusCode = responseData.response?.statusCode, statusCode == 200 {
                            observer.onNext(value)
                            observer.onCompleted()
                        }
                        else {
                            observer.onError(NSError(domain: "networkError", code: responseData.response?.statusCode ?? -1, userInfo: ["data": JSON(value)]))
                        }
                        
                    case .failure(let error):
                        print("Something went error")
                        print(responseData.response?.statusCode)
                        print(error)
                        print(error.localizedDescription)
                        print(responseData.result)
                        
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    /// Handles API Request. Returns Observable with JSON type.
    func APIRequestJSON(_ methodType: HTTPMethod, encoding: ParameterEncoding = URLEncoding.default, url: String = "", parameters: [String: Any] = [:]) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            let request = AF.request(url, method: methodType, parameters: parameters, encoding: encoding, headers: self.setHeaders(), interceptor: nil)
                .responseDecodable { (responseData: AFDataResponse<JSON>) in
                    print("====================")
                    print("URL: \(url)")
                    print("Status: \(String(describing: responseData.response?.statusCode))")
                    print("JSON Response: \(JSON(responseData.value))")
                    
                    switch responseData.result {
                    case .success(let value):
                        if let statusCode = responseData.response?.statusCode, statusCode == 200 {
                            observer.onNext(value)
                            observer.onCompleted()
                        }
                        else {
                            observer.onError(NSError(domain: "networkError", code: responseData.response?.statusCode ?? -1, userInfo: ["data": value]))
                        }
                        
                    case .failure(let error):
                        print("Something went error")
                        print(responseData.response?.statusCode)
                        print(error)
                        print(error.localizedDescription)
                        print(responseData.result)
                        
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    /// Handles API Upload Request. Returns Observable with JSON type.
    func APIUploadRequest(_ methodType: HTTPMethod, encoding: ParameterEncoding = URLEncoding.default, url: String = "", parameters: [String: Any] = [:], uploadData: Data, imageName: String, imageKeyName: String) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            let request = AF.upload(multipartFormData: { multipartData in
                for (key, value) in parameters {
                    multipartData.append((value as! String).data(using: .utf8) ?? Data(), withName: key)
                }
                
                multipartData.append(uploadData, withName: imageKeyName, fileName: imageName, mimeType: "image/jpg")
            }, to: url, method: .post, headers: self.setHeaders(), interceptor: nil)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseDecodable(of: JSON.self) { responseData in
                    print("====================")
                    print("URL: \(url)")
                    print("Status: \(String(describing: responseData.response?.statusCode))")
                    print("JSON Response: \(JSON(responseData.value))")
                    
                    switch responseData.result {
                    case .success(let value):
                        if let statusCode = responseData.response?.statusCode, statusCode == 200 {
                            observer.onNext(value)
                            observer.onCompleted()
                        }
                        else {
                            observer.onError(NSError(domain: "networkError", code: responseData.response?.statusCode ?? -1, userInfo: nil))
                        }
                        
                    case .failure(let error):
                        print("Something went error")
                        print(responseData.response?.statusCode)
                        print(error)
                        print(error.localizedDescription)
                        print(responseData.result)
                        
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    /// Check if network is working or not.
    func startNetworkMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connected")
                self.isInternetConnected = true
            }
            else {
                print("No internet")
                self.isInternetConnected = false
            }
        }
    }
    
    func stopNetworkMonitoring() {
        monitor.cancel()
    }
}
