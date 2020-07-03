//
//  CardsTests.swift
//  CardsTests
//
//  Created by Ilya Kharlamov on 28/05/2019.
//  Copyright © 2019 Ilya Kharlamov. All rights reserved.
//

import XCTest
@testable import PrettyCards

class CardsTests: XCTestCase {

    func testActivityIndicatorOffset() {
        let card = Card(frame: .zero)
        let offset = CGPoint(x: 5, y: 5)
        card.activityIndicatorOffset = offset
        XCTAssertEqual(card.activityIndicatorOffset, offset)
    }
    
    func testShadow(){
        let card = Card(frame: .zero)
        let shadow: Card.Shadow = .large
        card.setShadow(shadow)
        XCTAssertEqual(card.shadowColor, shadow.color)
        XCTAssertEqual(card.shadowOffset, shadow.offset)
        XCTAssertEqual(card.shadowRadius, shadow.radius)
        XCTAssertEqual(card.shadowOpacity, shadow.opacity)
    }
    
}
