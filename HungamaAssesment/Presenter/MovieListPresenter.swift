//
//  MovieListPresenter.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation

protocol MovieListingPresenterDelegate {
    func didReceiveMoviewList(movieResults: [MovieResults])
    func didReceiveError(errorMessage: String)
}

class MovieListPresenter {
    
    var delegate: MovieListingPresenterDelegate?
    let reachability = Reachability()!
    var movieResponse: MovieListingResponse?

    func fetchMovieData(page_number: Int) {
        
        if reachability.currentReachabilityStatus == .notReachable {
            delegate?.didReceiveError(errorMessage: "Not Connected To Internet")
            return
        }
        
        let params = [
            "api_key" : APIConstants.APP_API_KEY,
            "language" : APIConstants.APP_SERVICE_LANGUAGE,
            "page" : page_number
            ] as [String : Any]
        
        //Web service call for fetching list of movies
        APIRequest().callGetService(methodName: WebServiceMethods.WS_NOW_PLAYING, params: params, successBlock: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                //Parsing data
                self.movieResponse = try jsonDecoder.decode(MovieListingResponse.self, from: data)
              
                DispatchQueue.main.async {
                    self.delegate?.didReceiveMoviewList(movieResults: self.movieResponse?.results ?? [])
                }
            } catch {
                self.delegate?.didReceiveError(errorMessage: "Something Wrong")
            }
        }) { (error) in
            self.delegate?.didReceiveError(errorMessage: "Something Wrong")
        }
    }
}
