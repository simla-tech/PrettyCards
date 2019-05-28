//
//  ViewController.swift
//  PrettyCards-Demo
//
//  Created by Ilya Kharlamov on 28/05/2019.
//  Copyright © 2019 Ilya Kharlamov. All rights reserved.
//

import UIKit
import PrettyCards

class ViewController: UIViewController {

    // Outlets
    
    @IBOutlet weak var topCard: Card!
    @IBOutlet weak var button: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI(){
        
        // Configure top card
        self.topCard.cornerRadius = 12
        self.topCard.animation = .zoomOut
        self.topCard.setShadow(.medium)
        
        // Configure button
        self.button.animation = .fade
        self.button.cornerRadius = 8
        self.button.tapHandler = self.openGithubPage
        
    }
    
    func openGithubPage(){
        self.button.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            guard let url = URL(string: "https://gtthub.com/ilia3546/PrettyCards") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                self.button.stopAnimating()
            })
        })
    }

}

