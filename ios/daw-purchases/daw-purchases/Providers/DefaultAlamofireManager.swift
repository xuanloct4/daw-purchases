//
//  DefaultAlamofireManager.swift
//  ami-ios-regional-base
//
//  Created by loctv on 10/25/19.
//  Copyright © 2019 loctv. All rights reserved.
//
import Alamofire

class DefaultAlamofireManager: Alamofire.SessionManager {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "ami-channel-gateway-dev.public.ascendmoney-dev.internal": .disableEvaluation
        ]
        
        let sm = DefaultAlamofireManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager.init(policies: serverTrustPolicies))
        sm.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            
            print("received challenge")
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential =  URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = sm.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            
            return (disposition, credential)
        }
        
        return sm
    }()
}
