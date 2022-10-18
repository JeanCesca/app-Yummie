//
//  String+Extension.swift
//  Yummie
//
//  Created by Jean Ricardo Cesca on 18/10/22.
//

import Foundation

extension String {
    
    var asURL: URL? {
        return URL(string: self)
    }
    
}
