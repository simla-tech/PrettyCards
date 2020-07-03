//
//  ActivityIndicator.swift
//  retailCRM
//
//  Created by Ilya Kharlamov on 28/05/2019.
//  Copyright © 2019 Bluetech LLC. All rights reserved.
//

import UIKit

public protocol CardActivityIndicator {
    /// Starts the animation of the progress indicator.
    func startAnimating()
    /// Stops the animation of the progress indicator.
    func stopAnimating()
    /// A Boolean value indicating whether the activity indicator is currently running its animation.
    var isAnimating: Bool { get }
}

extension UIActivityIndicatorView: CardActivityIndicator {}
