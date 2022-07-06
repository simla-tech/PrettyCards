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
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }

    /// The color of the Card’s shadow. Animatable.
    open var shadowColor: UIColor? {
        get {
            if let shadowColor = self.layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return nil
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }

    /// The offset (in points) of the Card’s shadow. Animatable.
    open var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    /// The opacity of the Card’s shadow. Animatable.
    open var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    /// The radius to use when drawing rounded corners for the layer’s background.
    open var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.containerView.layer.cornerRadius = newValue
        }
    }

    public let containerView: UIView = .init()

    /// Tap callback
    public var tapHandler: TapHandler?
    public var tapBeginHandler: TapHandler?
    public var forwardTouchesToSuperview: Bool = true

    private var isTouched: Bool = false
    private let recognizer = UITapGestureRecognizer()

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

    private func configure() {
        self.layer.masksToBounds = false
        if #available(iOS 13.0, *) {
            self.layer.cornerCurve = .continuous
            self.containerView.layer.cornerCurve = .continuous
        }
        self.clipsToBounds = false
        self.isExclusiveTouch = true
        self.isUserInteractionEnabled = true
        self.configureRecognizer()
        self.configureContainer()
        self.moveSubviews()
    }

    private func configureRecognizer() {
        self.recognizer.delaysTouchesBegan = false
        self.recognizer.delegate = self
        self.recognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(self.recognizer)
    }

    private func configureContainer() {
        self.containerView.clipsToBounds = true
        self.containerView.backgroundColor = .clear
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.containerView)

        NSLayoutConstraint.activate([
            .init(item: self.containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }

    private func moveSubviews() {
        self.subviews
            .filter({ $0 != self.containerView })
            .forEach(self.containerView.addSubview)
    }

    // MARK: - Animations

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouched = true
        self.tapBeginHandler?()
        guard let animation = self.animation else {
            super.touchesBegan(touches, with: event)
            return
        }
        animation.animationBlock(self, false)
        if self.forwardTouchesToSuperview {
            super.touchesBegan(touches, with: event)
        }
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first, !self.containerView.frame.contains(touch.location(in: self.containerView)) {
            self.resetAnimation(handler: nil)
        }
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetAnimation(handler: self.tapHandler)
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resetAnimation(handler: nil)
        super.touchesCancelled(touches, with: event)
    }

    private func resetAnimation(handler: Card.TapHandler?) {

        defer {
            self.isTouched = false
        }

        guard self.isTouched else { return }

        guard let animation = self.animation else {
            handler?()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            handler?()
        })
        animation.animationBlock(self, true)

    }
}
