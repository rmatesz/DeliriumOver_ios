//
//  NumberPickerSheet.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 06..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class XibUIView: UIView {
    var xibFilename: String { fatalError("Needs to be overridden")}

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 240))
        initializeSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }

    fileprivate func initializeSubviews() {
        let view = Bundle.main.loadNibNamed(xibFilename, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
}
