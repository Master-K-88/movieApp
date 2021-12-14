//
//  Network.swift
//  moviesApp
//
//  Created by Prof K on 12/6/21.
//

import Foundation

class Network {
    
    static let shared = Network()
    var moviesData: [Movies]?
    var dataCompletion: ((Movies) ->Void)?
    var noMovieNotification: (()-> Void)?
    
    func requestForMovies(title: String) {
        let title = title
        let key = "71b382ad"
        let urlAPI = "http://www.omdbapi.com/?t=\(title)&apikey=\(key)"
        guard let url = URL(string: urlAPI) else {
            noMovieNotification?()
            return
        }
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [self] (data, response, error) -> Void in
            if (error != nil) {
                debugPrint(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                debugPrint(httpResponse as Any)
            }
            guard let data = data, error == nil else {
                return
            }
            var movieJson: Movies?
            do {
                movieJson = try JSONDecoder().decode(Movies.self, from: data)
            } catch {
                debugPrint(error)
            }
            guard let movie = movieJson else {
                noMovieNotification?()
                return
                
            }
            dataCompletion?(movie)
            
        })
        
        dataTask.resume()
    }
    
}
