//
//  ServiceRequest.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/4/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation
import KumulosSDK

final class ServiceRequest<T: CoreResponse> {
    
    private var cloudResponseClosure: ((T) -> Void)?
    private var cloudErrorClosure: ((_ status: String, _ code: Int?) -> Void)?
    private var finallyClosure: (() -> Void)?
    
    public init() {
        self.cloudResponseClosure = nil
        self.cloudErrorClosure = nil
    }
    
    @discardableResult
    func cloudResponse(_ closure: ((T) -> Void)? = nil) -> Self {
        self.cloudResponseClosure = closure
        return self
    }
    
    @discardableResult
    func cloudError(_ closure: ((_ status: String, _ code: Int?) -> Void)? = nil) -> Self {
        self.cloudErrorClosure = closure
        return self
    }
    
    @discardableResult
    func finally(_ closure: (() -> Void)?) -> Self {
        self.finallyClosure = closure
        return self
    }
   
    func handleResponseJSON(response: KSResponse) {
        defer {
            finallyClosure?()
        }
        
        guard let statusCode = response.responseCode else {
            return
        }
        
        switch statusCode {
        case 1:
            if let resource = response.payload as? [String: Any] {
                let obj = T(data: resource)
                cloudResponseClosure?(obj)
            } else {
                cloudErrorClosure?("Bad format", 500)
            }
        default:
            cloudErrorClosure?(response.responseMessage ?? "", Int(statusCode))
        }
    }
    
    func handleResponseJSONArray(response: KSResponse) {
        defer {
            finallyClosure?()
        }
        
        guard let statusCode = response.responseCode else {
            return
        }
        
        switch statusCode {
        case 1:
            if let resource = response.payload as? [[String: Any]] {
                let items = [
                    "items": resource
                ]
                let obj = T(data: items as [String: Any])
                cloudResponseClosure?(obj)
            } else {
                
                cloudErrorClosure?(response.responseMessage ?? "", Int(statusCode))
            }
        default:
            cloudErrorClosure?("Bad format", Int(statusCode))
        }
    }
    
    func handleEmptyResponse(response: KSResponse) {
        defer {
            finallyClosure?()
        }
        guard let statusCode = response.responseCode else {
            return
        }
        switch statusCode {
        case 1:
            let obj = T(data: ["succcess": 200])
            cloudResponseClosure?(obj)
        default:
             cloudErrorClosure?(response.responseMessage ?? "", Int(statusCode))
        }
    }
    
    func handleError(error: Error?) {
        
        
        guard let error = error else {
            cloudErrorClosure?("Error from server", 500)
            return
        }
        
        switch error._code {
        case NSURLErrorTimedOut:
            cloudErrorClosure?("Request timeout.", 408)
            
        default:
            cloudErrorClosure?("Error from server", 500)
        }
    }
}
