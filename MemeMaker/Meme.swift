//
//  Meme.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 01.07.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var bottomString: String?
    var topString: String?
    var originalImage: UIImage?
    var finalImage: UIImage?
    
    init(bottomString: String? = nil, topString: String? = nil, originalImage: UIImage? = nil, finalImage: UIImage? = nil) {
        self.bottomString = bottomString
        self.topString = topString
        self.originalImage = originalImage
        self.finalImage = finalImage
    }
}
