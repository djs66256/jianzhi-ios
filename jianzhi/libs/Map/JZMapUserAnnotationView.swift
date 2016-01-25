//
//  JZMapUserAnnotationView.swift
//  jianzhi
//
//  Created by daniel on 16/1/11.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMapUserAnnotationView: BMKAnnotationView {

    override init(annotation: BMKAnnotation, reuseIdentifier: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
