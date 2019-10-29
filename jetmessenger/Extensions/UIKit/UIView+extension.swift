//
//  UIView+extension.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit

extension UIView {
    func round() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
}
