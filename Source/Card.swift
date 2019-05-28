//
//  Card.swift
//  Lacoste POS
//
//  Created by Ilya Kharlamov on 15/12/2018.
//  Copyright © 2018 Bluetech LLC. All rights reserved.
//

import UIKit

/// Card view
public class Card: UIView, UIGestureRecognizerDelegate {
    
    public typealias TapHandler = () -> Void
    
    // MARK: - Variables
    
    /// Type of animation when tap
    public var animation: Animation?
    
    /// The blur radius (in points) used to render the Card’s shadow. Animatable.
    public var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    
    /// The color of the Card’s shadow. Animatable.
    public var shadowColor: UIColor? {
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
    public var shadowOffset: CGSize {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    
    /// The opacity of the Card’s shadow. Animatable.
    public var shadowOpacity: Float {
        set {
            self.layer.shadowOpacity = newValue
        }
        get {
            return self.layer.shadowOpacity
        }
    }
    
    /// The radius to use when drawing rounded corners for the layer’s background.
    public var cornerRadius: CGFloat {
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
    
    public var activityIndicator: (CardActivityIndicator & UIView) = UIActivityIndicatorView() {
        didSet {
            self.configureActivityIndicator()
        }
    }
    
    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = newValue
            self.activityIndicatorContainer.backgroundColor = newValue
        }
        get {
            return super.backgroundColor
        }
    }
    
    private var isTouched: Bool = false
    private let recognizer: UITapGestureRecognizer = .init()
    
    private var activityIndicatorContainer: UIView = .init()
    private var activityIndicatorXOffset: NSLayoutConstraint?
    private var activityIndicatorYOffset: NSLayoutConstraint?

    public var activityIndicatorOffset: CGPoint {
        get {
            return .init(x: self.activityIndicatorXOffset?.constant ?? 0,
                         y: self.activityIndicatorYOffset?.constant ?? 0)
        }
        set {
            if let constraint = self.activityIndicatorXOffset {
                self.activityIndicator.removeConstraint(constraint)
                self.activityIndicatorContainer.removeConstraint(constraint)
            }
            if let constraint = self.activityIndicatorYOffset {
                self.activityIndicator.removeConstraint(constraint)
                self.activityIndicatorContainer.removeConstraint(constraint)
            }
            self.activityIndicatorXOffset = self.activityIndicator.centerXAnchor.constraint(equalTo: self.activityIndicatorContainer.centerXAnchor, constant: newValue.x)
            self.activityIndicatorYOffset = self.activityIndicator.centerYAnchor.constraint(equalTo: self.activityIndicatorContainer.centerYAnchor, constant: newValue.y)
            self.activityIndicatorXOffset?.isActive = true
            self.activityIndicatorYOffset?.isActive = true
        }
    }
    
    // MARK: - Overriding
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
        self.configureActivityIndicator()
    }
    
    private func configureRecognizer(){
        self.recognizer.delaysTouchesBegan = false
        self.recognizer.delegate = self
        self.recognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(self.recognizer)
    }
    
    private func configureContainer(){
        self.containerView.clipsToBounds = true
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.containerView)
        
        NSLayoutConstraint.activate([
            .init(item: self.containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
        ])
    }
    
    private func configureActivityIndicator(){
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.stopAnimating()
        
        self.activityIndicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorContainer.backgroundColor = self.backgroundColor
        self.activityIndicatorContainer.alpha = 0
        self.activityIndicatorContainer.isUserInteractionEnabled = false
        
        self.activityIndicatorContainer.addSubview(self.activityIndicator)
        self.containerView.addSubview(self.activityIndicatorContainer)
        
        NSLayoutConstraint.activate([
            .init(item: self.activityIndicatorContainer, attribute: .bottom, relatedBy: .equal, toItem: self.containerView, attribute: .bottom, multiplier: 1, constant: 0),
            .init(item: self.activityIndicatorContainer, attribute: .top, relatedBy: .equal, toItem: self.containerView, attribute: .top, multiplier: 1, constant: 0),
            .init(item: self.activityIndicatorContainer, attribute: .leading, relatedBy: .equal, toItem: self.containerView, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: self.activityIndicatorContainer, attribute: .trailing, relatedBy: .equal, toItem: self.containerView, attribute: .trailing, multiplier: 1, constant: 0),
        ])
        
        self.activityIndicator.widthAnchor.constraint(equalToConstant: self.activityIndicator.frame.width).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: self.activityIndicator.frame.height).isActive = true
        
        self.activityIndicatorOffset = .init(x: 0, y: 0)
        
    }
    
    private func moveSubviews(){
        self.subviews
            .filter({ $0 != self.containerView && $0 != self.activityIndicatorContainer })
            .forEach(self.containerView.addSubview)
    }
    
    // MARK: - Animations
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let animation = self.animation else { return }
        self.isTouched = true
        animation.animationBlock(self, false)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetAnimation(handler: self.tapHandler)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    // MARK: - Activity indicator
    
    public func startAnimating(){
        self.isUserInteractionEnabled = false
        self.activityIndicator.startAnimating()
        self.containerView.bringSubviewToFront(self.activityIndicatorContainer)
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState], animations: {
            self.activityIndicatorContainer.alpha = 1
        })
    }
    
    public func stopAnimating(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState], animations: {
            self.activityIndicatorContainer.alpha = 0
        }) { (finished) in
            self.activityIndicator.stopAnimating()
            self.isUserInteractionEnabled = true
        }
    }
    
    public var isAnimating: Bool {
        return self.activityIndicator.isAnimating
    }
    
}

