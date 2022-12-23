//
//  NetworkMonitor.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import Alamofire
import Combine

public protocol NetworkMonitorProtocol {
    var connectionStatusSignal: CurrentValueSubject<NetworkConnectionStatus, Never> { get }
    var status: NetworkConnectionStatus { get }
    
    func startMonitoringConnectionStatus()
    func stopMonitoringConnectionStatus()
}

public  enum NetworkConnectionStatus {
    case connected
    case disconnected
}

final class NetworkMonitor: NetworkMonitorProtocol {
    // MARK: Protocol vars
    
    public let connectionStatusSignal: CurrentValueSubject<NetworkConnectionStatus, Never>
    
    public var status: NetworkConnectionStatus {
        get { reachabilityManager.isReachable ? .connected : .disconnected }
        set {
            connectionStatusSignal.send(newValue)
        }
    }
    
    // MARK: Private vars
    
    private let reachabilityManager: NetworkReachabilityManager
    
    // MARK: Init
    
    public init(reachabilityManager: NetworkReachabilityManager = .init()!) {
        self.reachabilityManager = reachabilityManager
        self.connectionStatusSignal = .init(.connected)
    }
    
    // MARK: Functions
    
    public func startMonitoringConnectionStatus() {
        reachabilityManager.startListening {[unowned self] (status) in
            switch status {
            case .notReachable:
                self.status = .disconnected
            default:
                self.status = .connected
            }
        }
    }
    
    public func stopMonitoringConnectionStatus() {
        reachabilityManager.stopListening()
    }
}
