//
//  MoviesSetCollectionViewCell.swift
//  moviesApp
//
//  Created by Prof K on 12/9/21.
//

import UIKit

class MoviesSetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteTapped(_ sender: Any) {
    }
    @IBAction func viewMoreTapped(_ sender: Any) {
    }
    
    func populateCell(with data: CoreMovies) {
        guard let poster = data.poster else { return }
        posterImg.sd_setImage(with: NSURL(string: poster) as URL?, completed: nil)
        lblTitle.text = data.title
        lblYear.text = data.year
        lblDirector.text = data.director
    }
    
}
