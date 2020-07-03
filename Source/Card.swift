//
//  Card.swift
//  Lacoste POS
//
//  Created by Ilya Kharlamov on 15/12/2018.
//  Copyright © 2018 Bluetech LLC. All rights reserved.
//

import UIKit

/// Card view
open class Card: UIView, UIGestureRecognizerDelegate {
    
    public typealias TapHandler = () -> Void
    
    // MARK: - Variables
    
    /// Type of animation when tap
    open var animation: Animation?
    
    /// The blur radius (in points) used to render the Card’s shadow. Animatable.
    open var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    
    /// The color of the Card’s shadow. Animatable.
    open var shadowColor: UIColor? {
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
        get {
            if let shadowColor = self.layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return nil
        }
    }
    
    /// The offset (in points) of the Card’s shadow. Animatable.
    open var shadowOffset: CGSize {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    
    /// The opacity of the Card’s shadow. Animatable.
    open var shadowOpacity: Float {
        set {
            self.layer.shadowOpacity = newValue
        }
        get {
            return self.layer.shadowOpacity
        }
    }
    
    /// The radius to use when drawing rounded corners for the layer’s background.
    open var cornerRadius: CGFloat {
        set{
            self.layer.cornerRadius = newValue
            self.containerView.layer.cornerRadius = newValue
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
    public let containerView: UIView = .init()

    /// Tap callback
    public var tapHandler: TapHandler?
    
    private var isTouched: Bool = false
    private let recognizer: UITapGestureRecognizer = .init()
    
    // MARK: - Overriding
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    // MARK: - Configurations
    
    private func configure(){
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.isExclusiveTouch = true
        self.isUserInteractionEnabled = true
        self.configureRecognizer()
        self.configureContainer()
        self.moveSubviews()
    }
    
    private func configureRecognizer(){
        self.recognizer.delaysTouchesBegan = false
        self.recognizer.delegate = self
        self.recognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(self.recognizer)
    }
    
    private func configureContainer(){
        self.containerView.clipsToBounds = true
        self.containerView.backgroundColor = .clear
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.containerView)
        
        NSLayoutConstraint.activate([
            .init(item: self.containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
        ])
    }
    
    private func moveSubviews(){
        self.subviews
            .filter({ $0 != self.containerView })
            .forEach(self.containerView.addSubview)
    }
    
    // MARK: - Animations
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let animation = self.animation else { return }
        self.isTouched = true
        animation.animationBlock(self, false)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetAnimation(handler: self.tapHandler)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetAnimation(handler: nil)
    }
    
    private func resetAnimation(handler: Card.TapHandler?){
        
        guard let animation = self.animation else {
            handler?()
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: handler ?? {})
        
        if self.isTouched {
            self.isTouched.toggle()
            animation.animationBlock(self, true)
        }
    }
}

