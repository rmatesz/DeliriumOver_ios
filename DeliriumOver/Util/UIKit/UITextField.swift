//
//  EditText.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 08. 25..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var safeText: String {
        return text ?? ""
    }
}
