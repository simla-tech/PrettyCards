//
//  Shadow.swift
//  Lacoste POS
//
//  Created by Ilya Kharlamov on 19/12/2018.
//  Copyright © 2018 Bluetech LLC. All rights reserved.
//

import UIKit

public protocol CardShadowProtocol {
    var opacity: Float { get }
    var radius: CGFloat { get }
    var offset: CGSize { get }
    var color: UIColor? { get }
}

extension Card {
    
    public enum Shadow: CardShadowProtocol {
        
        case huge
        case large
        case medium
        case small
        
        public var opacity: Float {
            switch self {
            case .huge: return 0.1
            case .large: return 0.2
            case .medium: return 0.15
            case .small: return 0.2
            }
        }
        
        public var radius: CGFloat {
            switch self {
            case .huge: return 40
            case .large: return 16
            case .medium: return 12
            case .small: return 8
            }
        }
        
        public var offset: CGSize {
            return .zero
        }
        
        public var color: UIColor? {
            return .black
        }
        
    }
    
    public func setShadow(_ shadow: Card.Shadow){
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }
    
    public func setShadow<T: CardShadowProtocol>(_ shadow: T){
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }
    
}
