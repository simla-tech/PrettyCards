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
        
        @available(*, unavailable, message: "Use .large instead")
        case huge
        case large
        case medium
        case small
        
        public var opacity: Float {
            return 0.16
        }
        
        public var radius: CGFloat {
            switch self {
            case .large: return 32
            case .medium: return 16
            case .small: return 2
            }
        }
        
        public var offset: CGSize {
            switch self {
            case .small:
                return .init(width: 0, height: 2)
            case .medium:
                return .init(width: 0, height: 8)
            case .large:
                return .init(width: 0, height: 16)
            }
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
    
    public func setShadow(_ shadow: CardShadowProtocol){
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }
    
}
