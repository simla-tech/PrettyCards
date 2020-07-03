//
//  Animation.swift
//  Lacoste POS
//
//  Created by Ilya Kharlamov on 19/12/2018.
//  Copyright © 2018 Bluetech LLC. All rights reserved.
//

import UIKit

extension Card {
    
    /// Card animation
    public class Animation {
        
        /// Animation closure
        public typealias Closure = ((_ card: Card, _ isReverced: Bool)->Void)

        internal var animationBlock: Closure
        
        fileprivate init(_ animationBlock: @escaping Closure) {
            self.animationBlock = animationBlock
        }
        
    }
    
}

// MARK: - Default animations

extension Card.Animation {

    
    /// Zoom animation for Card
    ///
    /// - Parameters:
    ///   - scale: Card X & Y scale
    ///   - duration: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them. **Default is 0.35**.
    ///   - damping: The damping ratio for the spring animation as it approaches its quiescent state. To smoothly decelerate the animation without oscillation, use a value of 1. Employ a damping ratio closer to zero to increase oscillation. **Default is 1.0**.
    ///   - velocity: The initial spring velocity. For smooth start to the animation, match this value to the view’s velocity as it was prior to attachment. Default is **1.5**.
    /// - Returns: Animation object
    public static func zoom(to scale: CGFloat,
                     duration: TimeInterval = 0.35,
                     damping: CGFloat = 1,
                     velocity: CGFloat = 1.5) -> Card.Animation {
        
        return Card.Animation({ (card, isReverced) in
            UIView.animate(withDuration: duration,
                           delay: isReverced ? 0.1 : 0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: velocity,
                           options: [.beginFromCurrentState],
                           animations: {
                            card.transform = isReverced ?
                                .identity :
                                .init(scaleX: scale, y: scale)
            })
        })
        
    }
    
    
    /// Fade animation for Card
    ///
    /// - Parameters:
    ///   - alpha: The value of this property is a floating-point number in the range 0.0 to 1.0, where 0.0 represents totally transparent and 1.0 represents totally opaque.
    ///   - duration: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them. Default value is 0.1
    /// - Returns: Animation object
    public static func fade(to alpha: CGFloat, duration: TimeInterval = 0.15) -> Card.Animation {
        return Card.Animation({ (card, isReverced) in
            UIView.animate(withDuration: duration, delay: isReverced ? 0.05 : 0, options: [.beginFromCurrentState], animations: {
                card.alpha =  isReverced ? 1 : alpha
            })
        })
    }
    
    
    /// Make custom Animation
    ///
    /// - Parameter animationBlock: Custom animation closure
    /// - Returns: Animation object
    public static func custom(_ animationBlock: @escaping Card.Animation.Closure) -> Card.Animation {
        return .init(animationBlock)
    }
    
    /// Zoom in Card to 1.05 scale
    public static var zoomIn: Card.Animation { return .zoom(to: 1.05) }
    
    /// Zoom out Card to 0.95 scale
    public static var zoomOut: Card.Animation { return .zoom(to: 0.95) }
    
    /// Fade out Card to 0.7 alpha
    public static var highlight: Card.Animation{ return .fade(to: 0.7) }
    
}
