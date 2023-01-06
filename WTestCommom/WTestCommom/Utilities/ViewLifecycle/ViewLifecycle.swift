//
//  ViewLifecycle.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import Combine
import UIKit

protocol LifecycleObservable {
    var viewDidLoadObs: Trigger { get }
    var viewWillAppearObs: Trigger { get }
    var viewDidAppearObs: Trigger { get }
    var deinitializeObs: Trigger { get }
}

open class ViewLifecycle: LifecycleObservable {
    
    public enum Event {
        case viewDidLoad,
             viewWillAppear,
             viewDidAppear,
             viewWillDisappear,
             viewDidDisappear,
             deinitialize
    }
    
    public private(set) lazy var viewDidLoadObs = Trigger()
    public private(set) lazy var viewWillAppearObs = Trigger()
    public private(set) lazy var viewDidAppearObs = Trigger()
    public private(set) lazy var viewWillDisappearObs = Trigger()
    public private(set) lazy var viewDidDisappearObs = Trigger()
    public private(set) lazy var deinitializeObs = Trigger()
    
    public func trigger(_ event: Event) {
        switch event {
        case .viewDidLoad:
            viewDidLoadObs.trigger()
        case .viewWillAppear:
            viewWillAppearObs.trigger()
        case .viewDidAppear:
            viewDidAppearObs.trigger()
        case .viewWillDisappear:
            viewWillDisappearObs.trigger()
        case .viewDidDisappear:
            viewDidDisappearObs.trigger()
        case .deinitialize:
            deinitializeObs.trigger()
        }
    }
}

protocol TraitCollectionObservable {
    var didChangeObs: CurrentValueSubject<UITraitCollection?, Never> { get }
}

open class ViewTraitCollection: TraitCollectionObservable {
    public private(set) lazy var didChangeObs: CurrentValueSubject<UITraitCollection?, Never> = .init(nil)
    
    public func trigger(_ traitCollection: UITraitCollection?) {
        didChangeObs.send(traitCollection)
    }
}

protocol ViewWillTransitionObservable {
    var didChangeObs: Trigger { get }
}

open class ViewWillTransition: ViewWillTransitionObservable {
    public private(set) lazy var didChangeObs: Trigger = .init()
    
    public func trigger() {
        didChangeObs.trigger()
    }
}
