//
//  MoreDetailViewController.swift
//  moviesApp
//
//  Created by Prof K on 12/13/21.
//

import UIKit

class MoreDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let movieCollectionIdentifier = "MovieCollectionViewCell"
    var index: Int?
    
    let viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        
        // Register nib or xib cells
        let nib = UINib(nibName: movieCollectionIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: movieCollectionIdentifier)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        backbtnTapped()
    }
    
    func backbtnTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MoreDetailViewController: UICollectionViewDelegate {
    
}

extension MoreDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionIdentifier, for: indexPath) as! MovieCollectionViewCell
        if let index = self.index {
            guard let data = viewModel.savedMovies?[index] else { return cell }
            cell.populateCell(with: data)
        }
        
        cell.moreInfoTapped()
        cell.seeMoreBtn.isHidden = true
        cell.btnAddFav.isHidden = true
        return cell
    }
    
    
}

extension MoreDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 1300)
    }
}
