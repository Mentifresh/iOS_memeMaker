//
//  MemeCollectionViewController.swift
//  MemeMaker
//
//  Created by Daniel Kilders Díaz on 05.07.19.
//  Copyright © 2019 Daniel Kilders. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCell"

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var memeCollectionView: UICollectionView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memeCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sent Memes"
        
        setupCollectionViewLogic()
        setupCollectionViewLayout()
    }
    
    fileprivate func setupCollectionViewLayout() {
        self.view.addSubview(memeCollectionView)
        
        NSLayoutConstraint.activate([
            memeCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            memeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            memeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            memeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

    fileprivate func setupCollectionViewLogic() {
        // Register cell classes
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (screenWidth / 3) - 10, height: (screenWidth / 3) - 10 ) // -10 is subtracting the insets
        
        memeCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        memeCollectionView.backgroundColor = .white
        
        memeCollectionView.delegate = self
        memeCollectionView.dataSource = self
        
        memeCollectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        cell.meme = memes[indexPath.row].finalImage
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MemeDetailController.self)) as! MemeDetailController
        
        vc.meme = memes[indexPath.row].finalImage
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
