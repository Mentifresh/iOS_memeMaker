//
//  MemeTableController.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 04.07.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import UIKit

class MemeTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memeTableview: UITableView!
    
    private let cellIdentifier = "memeTableCell"
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sent Memes"
        
        memeTableview.delegate = self
        memeTableview.dataSource = self
        
        memeTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memeTableview.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.imageView?.image = memes[indexPath.row].finalImage
        cell.textLabel?.text = memes[indexPath.row].topString
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MemeDetailController.self)) as! MemeDetailController
        
        vc.meme = memes[indexPath.row].finalImage
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
