//
//  CALayer+ApplyShadow.swift
//  PrettyCards
//
//  Created by Ilya Kharlamov on 10/4/22.
//  Copyright © 2022 DIGITAL RETAIL TECHNOLOGIES, S.L. All rights reserved.
//

import UIKit

public extension CALayer {

    func applyCardShadow(_ shadow: Card.Shadow) {
        self.shadowColor = shadow.color?.cgColor
        self.shadowOffset = shadow.offset
        self.shadowOpacity = shadow.opacity
        self.shadowRadius = shadow.radius
    }

}
