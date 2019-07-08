//
//  MemeDetailController.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 05.07.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import UIKit

class MemeDetailController: UIViewController {

    @IBOutlet weak var memeImageview: UIImageView!
    
    var meme: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = meme {
            memeImageview.image = image
        }
    }
}
