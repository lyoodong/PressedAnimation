//
//  Model.swift
//  PressedAnimation
//
//  Created by Dongwan Ryoo on 11/24/24.
//

import UIKit

struct Model {
    let logoColor: UIColor
    let title: String
    let subTitle: String
    
    static func mock() -> [Self] {
        return [ Model(logoColor: .yellow, title: "국민 은행", subTitle: "600,000"),
                 Model(logoColor: .blue, title: "신한 은행", subTitle: "50,000"),
                 Model(logoColor: .green, title: "하나 은행", subTitle: "100,000")
        ]
    }
}
