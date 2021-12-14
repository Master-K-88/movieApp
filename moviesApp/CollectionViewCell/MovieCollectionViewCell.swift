//
//  MovieCollectionViewCell.swift
//  moviesApp
//
//  Created by Prof K on 12/6/21.
//

import UIKit
import SDWebImage

protocol MoviesDelegate: AnyObject {
    func moreBtnTapped()
    func addFav(model: Movies)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var ratedLbl: UILabel!
    @IBOutlet weak var releasedLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var writerLbl: UILabel!
    @IBOutlet weak var actorsLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var awardsLbl: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var ratedStackView: UIStackView!
    @IBOutlet weak var langStackView: UIStackView!
    
    @IBOutlet weak var awardStackView: UIStackView!
    @IBOutlet weak var countryStackView: UIStackView!
    @IBOutlet weak var actorStackView: UIStackView!
    @IBOutlet weak var writerStackView: UIStackView!
    @IBOutlet weak var releasedStackView: UIStackView!
    @IBOutlet weak var genreStackView: UIStackView!
    @IBOutlet weak var seeMoreBtn: UIButton!
    
    @IBOutlet weak var btnAddFav: UIButton!
    weak var delegate: MoviesDelegate?
    var viewModel: MoviesViewModel?
    var newMovie: Movies?
    var hideState: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = MoviesViewModel()
        moreBtnTapped(with: true)
        // Initialization code
    }
    
    func populateCell(with model: Movies) {
        newMovie = model
        titleLbl.text = model.Title
        yearLbl.text = model.Year
        directorLbl.text = model.Director
        posterImg.sd_setImage(with: NSURL(string: model.Poster) as URL?)
        ratedLbl.text = model.Rated
        genreLbl.text = model.Genre
        langLbl.text = model.Language
        countryLbl.text = model.Country
        actorsLbl.text = model.Actors
        writerLbl.text = model.Writer
        awardsLbl.text = model.Awards
    }
    
    func populateCell(with model: CoreMovies) {
        
        DispatchQueue.main.async {
            self.titleLbl.text = model.title
            self.yearLbl.text = model.year
            self.directorLbl.text = model.director
            self.posterImg.sd_setImage(with: NSURL(string: model.poster!) as URL?)
            self.ratedLbl.text = model.rated
            self.genreLbl.text = model.genre
            self.langLbl.text = model.lang
            self.countryLbl.text = model.country
            self.actorsLbl.text = model.actors
            self.writerLbl.text = model.writer
            self.awardsLbl.text = model.awards
        }
        
    }
    
    @IBAction func seeMoreBtn(_ sender: Any) {
        moreInfoTapped()
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        guard let newMovie = newMovie else {
            return
        }
        delegate?.addFav(model: newMovie)
    }
    
    func moreInfoTapped() {
        hideState = !hideState
        let btnText = viewModel?.seeMoreBtnTapped(with: hideState)
        seeMoreBtn.setTitle(btnText, for: .normal)
        moreBtnTapped(with: hideState)
    }
    
    func  moreBtnTapped(with hideState: Bool) {
        ratedStackView.isHidden = hideState
        langStackView.isHidden = hideState
        awardStackView.isHidden = hideState
        countryStackView.isHidden = hideState
        genreStackView.isHidden = hideState
        actorStackView.isHidden = hideState
        writerStackView.isHidden = hideState
        releasedStackView.isHidden = hideState
    }
    
}
