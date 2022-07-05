//
//  String+Ext.swift
//  PostsFeed
//
//  Created by user on 05.07.2022.
//

import UIKit

extension String {
    func heightForView(font: UIFont, width: CGFloat) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self

        label.sizeToFit()
        
        return label.frame.height
    }
    
    func heightForView(font: UIFont, width: CGFloat, lines: Int) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = lines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self

        label.sizeToFit()
        
        return label.frame.height
    }
}
