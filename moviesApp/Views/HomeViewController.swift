//
//  ViewController.swift
//  moviesApp
//
//  Created by Prof K on 12/6/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let movieCollectionIdentifier = "MovieCollectionViewCell"
    
    let viewModel = MoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        
        // Register nib or xib cells
        let nib = UINib(nibName: movieCollectionIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: movieCollectionIdentifier)
        
        viewModel.tranferData = { data in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.getMoviesData()
        viewModel.alertHandlerHomeVC = { saved in
            print("Reloading")
            DispatchQueue.main.async {
                let alert = UIAlertController(title: saved, message: "Movie \(saved) as favorite", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
//        print("The new Movie title is: \(viewModel.moviesData?.Title)")
    }
    


}

extension HomeViewController: UICollectionViewDelegate, MoviesDelegate {
    func moreBtnTapped() {
        
    }
    
    func addFav(model: Movies) {
        viewModel.saveMovie(movie: model, typeVC: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You have selected this item")
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionIdentifier, for: indexPath) as! MovieCollectionViewCell
        guard let data = viewModel.moviesData else { return cell }
        cell.populateCell(with: data)
        cell.delegate = self
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 1300)
    }
}
