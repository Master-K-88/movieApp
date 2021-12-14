//
//  FavoriteViewController.swift
//  moviesApp
//
//  Created by Prof K on 12/6/21.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = MoviesViewModel()
    let identifier = "MoviesSetCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        
        // Register nib or xib cells
        let nib = UINib(nibName: identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        
        viewModel.reloadHandler = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchMovies()
        viewModel.alertHandler = {
            let alert = UIAlertController(title: "Deletion", message: "Item deleted successfully", preferredStyle: .alert)
            let noAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(noAction)
            self.present(alert, animated: true, completion: nil)
            self.collectionView.reloadData()
        }
    }
    
    func navigateToMoreInfo(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newVC = storyboard.instantiateViewController(withIdentifier: "MoreDetailViewController") as? MoreDetailViewController else {
            return
        }
        newVC.index = index
        present(newVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You have selected this item")
        
    }
}
extension FavoriteViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewModel.savedMovies else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MoviesSetCollectionViewCell
        guard let data = viewModel.savedMovies else { return cell }
        cell.populateCell(with: data[indexPath.row])
        cell.delegate = self
        cell.btnDelete.tag = indexPath.row
        cell.btnMoreInfo.tag = indexPath.row
        return cell
    }
    
    
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 155)
    }
}

extension FavoriteViewController: MoviesCollectionViewDelegate {
    func seeMoreDetails(at index: Int) {
        navigateToMoreInfo(index: index)
        
    }
    
    func deleteMovie(at index: Int) {
        let alert = UIAlertController(title: "Delete Movie", message: "Are you sure you want to delete this movie from your collection of movies?.", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let delAction = UIAlertAction(title: "Yes", style: .default) { _ in
            print("You clicked on Yes.")
            self.viewModel.deleteMovie(at: index)
        }
        alert.addAction(noAction)
        alert.addAction(delAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
