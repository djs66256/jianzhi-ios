//
//  JZMapUserAnnotationView.swift
//  jianzhi
//
//  Created by daniel on 16/1/11.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

class JZMapAnnotationView: BMKAnnotationView {

    override init(annotation: BMKAnnotation, reuseIdentifier: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class JZMapUserAnnotationView: JZMapAnnotationView {
    
    override init(annotation: BMKAnnotation, reuseIdentifier: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage(named: "anno")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class JZMapCompanyAnnotationView: JZMapAnnotationView {
    
    override init(annotation: BMKAnnotation, reuseIdentifier: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image = UIImage(named: "anno_company")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
