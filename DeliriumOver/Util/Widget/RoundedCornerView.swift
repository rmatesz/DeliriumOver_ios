//
//  RoundedCornerView.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 08..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class RoundedCornerView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
