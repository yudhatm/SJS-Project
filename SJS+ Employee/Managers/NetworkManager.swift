//
//  NetworkManager.swift
//  SJS+ Employee
//
//  Created by Buana on 20/05/22.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import Network

class NetworkManager {
    static var shared = NetworkManager()
    
    var header: HTTPHeaders = [:]
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    
    var isInternetConnected = false
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    //Set headers
    private func setHeaders() -> HTTPHeaders {
        header = [
            "Authorization": "Basic bmFuYS5udXJ3YW5kYUBnbWFpbC5jb206a2VyamErc2pzKzIwMjE="
        ]
        return header
    }
    
    func APIRequest<T: Codable> (_ methodType: HTTPMethod, url: String = "", parameters: [String: Any] = [:]) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(url, method: methodType, parameters: parameters, encoding: URLEncoding.default, headers: self.setHeaders(), interceptor: nil)
                .responseDecodable { (responseData: AFDataResponse<T>) in
                    switch responseData.result {
                    case .success(let value):
                        print("response: \(value)")
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
