//
//  MoviesViewModel.swift
//  moviesApp
//
//  Created by Prof K on 12/6/21.
//

import Foundation
import CoreData
import UIKit

class MoviesViewModel {
    
    var moviesData: Movies!
    var tranferData: ((Movies) -> Void)?
    var noData: ((Bool, String) -> Void)?
    var reloadHandler: (() -> Void)?
    var alertHandlerHomeVC: ((String) -> Void)?
    var alertHandlerSearchVC: ((String) -> Void)?
    var alertHandler: (() -> Void)?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedMovies: [CoreMovies]?
    
    init() {
        self.getMoviesData()
        fetchMovies()
    }
    
    func getMoviesData(title: String = "BatMan") {
        let title = title
        Network.shared.requestForMovies(title: title)
        Network.shared.dataCompletion = { moviesResponse in
            self.moviesData = moviesResponse
            self.tranferData?(moviesResponse)
        }
    }
    //MARK: - Fetch data from the coredata database
    func fetchMovies() {
        do {
            savedMovies = try context.fetch(CoreMovies.fetchRequest())
            self.reloadHandler?()
        } catch {
            
        }
    }
    
    func saveMovie(movie: Movies, typeVC: Int) {
        let newMovie = CoreMovies(context: context)
        newMovie.title = movie.Title
        newMovie.actors = movie.Actors
        newMovie.awards = movie.Awards
        newMovie.director = movie.Director
        newMovie.year = movie.Year
        newMovie.poster = movie.Poster
        newMovie.rated = movie.Rated
        newMovie.released = movie.Released
        newMovie.genre = movie.Genre
        newMovie.writer = movie.Writer
        newMovie.lang = movie.Language
        newMovie.country = movie.Country
        do {
            try context.save()
            if typeVC == 0 {
                self.alertHandlerHomeVC?("Saved")
            } else if typeVC == 1{
                self.alertHandlerSearchVC?("Saved")
            }
        } catch {
            
        }
        
        fetchMovies()
        
    }
    
    
    
    func searchMovie(title: String?) {
        
        if let title = title, title != "" {
            noData?(false, "")
            var searchItem = ""
            let newSearch = title.split(separator: " ")
                if newSearch.count > 1 {
                    for num in 0 ..< newSearch.count {
                        if num < (newSearch.count - 1) {
                            searchItem = searchItem + newSearch[num] + "-"
                        } else {
                            searchItem += newSearch[num]
                        }
                    }
                } else {
                    searchItem = "\(newSearch[0])"
                }
            
            Network.shared.requestForMovies(title: searchItem)
            Network.shared.dataCompletion = { moviesResponse in
                self.moviesData = moviesResponse
                self.tranferData?(moviesResponse)
            }
            Network.shared.noMovieNotification = {
                self.noData?(true, "No such Movies in our DataBase")
            }
        } else {
            noData?(true, "No data found")
        }
        
    }
    
    func seeMoreBtnTapped(with btnState: Bool) -> String {
        if !btnState {
            return "Hide"
        } else {
            return "See More"
        }
    }
    
    func deleteMovie (at index: Int) {
        guard let selectedMovie = savedMovies?[index] else {
            return
        }
        context.delete(selectedMovie)
        
        do {
            try context.save()
            alertHandler?()
        } catch {
            
        }
        fetchMovies()
    }
}
