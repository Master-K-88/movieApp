//
//  SearchViewController.swift
//  moviesApp
//
//  Created by Prof K on 12/6/21.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    let movieCollectionIdentifier = "MovieCollectionViewCell"
    
    
    let viewModel = MoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = true
        lblNoData.isHidden = false
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
        
        viewModel.noData = { hide, text in
            DispatchQueue.main.async {
                self.lblNoData.text = text
                self.collectionView.isHidden = hide
                self.lblNoData.isHidden = !hide
            }
        }
        
        viewModel.alertHandlerSearchVC = { saved in
                let alert = UIAlertController(title: saved, message: "Movie \(saved) as favorite", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        viewModel.getMoviesData(title: "new")
    }
    
    @IBAction func goSearch(_ sender: Any) {
        searchMovie.resignFirstResponder()
        let search = searchMovie.text
        viewModel.searchMovie(title: search)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, MoviesDelegate {
    func moreBtnTapped() {
        
    }
    
    func addFav(model: Movies) {
        viewModel.saveMovie(movie: model, typeVC: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You have selected this item")
    }
}
extension SearchViewController: UICollectionViewDataSource {
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

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 1300)
    }
}
