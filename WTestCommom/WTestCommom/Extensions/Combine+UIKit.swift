//
//  Combine+UIKit.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Foundation
import UIKit
import Combine

protocol CombineCompatible {}

// MARK: - UIBarButtonItem

public extension UIBarButtonItem {
    final class Subscription<SubscriberType: Subscriber, Input: UIBarButtonItem>: Combine.Subscription where SubscriberType.Input == Input {
        private var subscriber: SubscriberType?
        private let input: Input
        
        public init(subscriber: SubscriberType, input: Input) {
            self.subscriber = subscriber
            self.input = input
            input.target = self
            input.action = #selector(eventHandler)
        }
        
        public func request(_ demand: Subscribers.Demand) {}
        
        public func cancel() {
            subscriber = nil
        }
        
        @objc private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }
    
    struct Publisher<Output: UIBarButtonItem>: Combine.Publisher {
        public typealias Output = Output
        public typealias Failure = Never
        
        let output: Output
        
        public init(output: Output) {
            self.output = output
        }
        
        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIBarButtonItem: CombineCompatible {
    public convenience init(image: UIImage?, style: UIBarButtonItem.Style, isEnabled: Bool = true, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.isEnabled = isEnabled
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, isEnabled: Bool = true, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.isEnabled = isEnabled
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }
    
    public convenience init(title: String?, style: UIBarButtonItem.Style, isEnabled: Bool = true, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.isEnabled = isEnabled
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, isEnabled: Bool = true, cancellables: inout Set<AnyCancellable>, action: @escaping () -> Void) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.isEnabled = isEnabled
        self.publisher.sink { _ in action() }.store(in: &cancellables)
    }
}

extension CombineCompatible where Self: UIBarButtonItem {
    var publisher: UIBarButtonItem.Publisher<UIBarButtonItem> {
        .init(output: self)
    }
}

// MARK: - UIControl

extension UIControl {
    final class Subscription<SubscriberType: Subscriber, Control: UIControl>: Combine.Subscription where SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let input: Control

        public init(subscriber: SubscriberType, input: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.input = input
            input.addTarget(self, action: #selector(eventHandler), for: event)
        }

        public func request(_ demand: Subscribers.Demand) {}

        public func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }

    struct Publisher<Output: UIControl>: Combine.Publisher {
        public typealias Output = Output
        public typealias Failure = Never

        let output: Output
        let event: UIControl.Event

        public init(output: Output, event: UIControl.Event) {
            self.output = output
            self.event = event
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension CombineCompatible where Self: UIControl {
    func publisher(for event: UIControl.Event) -> UIControl.Publisher<UIControl> {
        .init(output: self, event: event)
    }
}
