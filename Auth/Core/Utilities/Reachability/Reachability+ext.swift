//
//  Reachability+ext.swift
//  Auth
//
//  Created by Andrey Ulanov on 07.05.2024.
//

import Foundation
import Reachability
import Combine


extension Reachability {

    var onReachabilityChanged: AnyPublisher<Reachability, Never> {
        NotificationCenter.default
            .publisher(for: .reachabilityChanged, object: self)
            .compactMap {
                $0.object as? Reachability
            }
            .eraseToAnyPublisher()
    }


    var status: AnyPublisher<Connection, Never> {
        onReachabilityChanged
            .map(\.connection)
            .eraseToAnyPublisher()
    }

    var isReachable: AnyPublisher<Bool, Never> {
        onReachabilityChanged
            .map { $0.connection != .unavailable }
            .eraseToAnyPublisher()
    }

    var isConnected: AnyPublisher<Void, Never> {
        isReachable
            .filter { $0 }
            .map { _ in }
            .eraseToAnyPublisher()
    }

    var isDisconnected: AnyPublisher<Void, Never> {
        isReachable
            .filter { !$0 }
            .map { _ in }
            .eraseToAnyPublisher()
    }

}
