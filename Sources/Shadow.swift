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

        case soft
        case large
        case medium
        case small

        public var opacity: Float {
            switch self {
            case .soft: return 0.08
            default: return 0.16
            }
        }

        public var radius: CGFloat {
            switch self {
            case .large: return 32
            case .medium, .soft: return 16
            case .small: return 2
            }
        }

        public var offset: CGSize {
            switch self {
            case .small:
                return CGSize(width: 0, height: 2)
            case .medium, .soft:
                return CGSize(width: 0, height: 8)
            case .large:
                return CGSize(width: 0, height: 16)
            }
        }

        public var color: UIColor? {
            return UIColor(red: 30/255, green: 34/255, blue: 72/255, alpha: 1)
        }

    }

    public func setShadow(_ shadow: Card.Shadow) {
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }

    public func setShadow<T: CardShadowProtocol>(_ shadow: T) {
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }

    public func setShadow(_ shadow: CardShadowProtocol) {
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }

}
