//
//  MovieDetailsPresenter.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 03/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterDelegate {
    func didFetchedData(movieDetailsData: [MovieDetailsSection])
}

class MovieDetailsPresenter {

    var delegate: MovieDetailsPresenterDelegate?
    let reachability = Reachability()!
    
    var movieDetailsDataArray : [MovieDetailsSection]? = []
//    var movieDetails: MovieResults?
    var id: String = ""
    let jsonDecoder = JSONDecoder()
    
    init(movieID: String){
        self.id = movieID
    }
    

    //Function to fetch synopsis for the movie detail screen
    func fetchSynopsis(movieDetailsDataArray: [MovieDetailsSection]) {
        self.movieDetailsDataArray = movieDetailsDataArray
        
        if reachability.currentReachabilityStatus == .notReachable {
            return
        }
        
        let params = [
            "api_key" : APIConstants.APP_API_KEY,
            "language" : APIConstants.APP_SERVICE_LANGUAGE,
            ] as [String : Any]
        
        let methodName = id
        
        APIRequest().callGetService(methodName: methodName, params: params, successBlock: { (data) in
            do {
                let synopsisResponse = try self.jsonDecoder.decode(MovieSynopsisResponse.self, from: data)

                self.movieDetailsDataArray?.append(MovieDetailsSection(type: .synopsis, data: synopsisResponse))
                
                self.fetchCredits()

                DispatchQueue.main.async {
                    self.delegate?.didFetchedData(movieDetailsData: self.movieDetailsDataArray ?? [])
                }
            } catch {
                
            }
        }) { (error) in
            self.fetchCredits()
        }
        
    }
    
    //Function to fetch reviews for the movie detail screen
//    func fetchReviews() {
//
//        if reachability.currentReachabilityStatus == .notReachable {
//            return
//        }
//
//        let params = [
//            "api_key" : APIConstants.APP_API_KEY,
//            "language" : APIConstants.APP_SERVICE_LANGUAGE,
//            ] as [String : Any]
//
//        let methodName = "\(id)/\(WebServiceMethods.WS_REVIEWS)"
//
//        APIRequest().callGetService(methodName: methodName, params: params, successBlock: { (data) in
//            do {
//                let reviewsResponse = try self.jsonDecoder.decode(MovieReviewsResponse.self, from: data)
//
//                if reviewsResponse.results?.count ?? 0 > 0 {
//                    self.movieDetailsDataArray?.append(MovieDetailsSection(type: .reviews, data: reviewsResponse))
//                }
//
//                self.fetchCredits()
//
//                DispatchQueue.main.async {
//                    self.delegate?.didFetchedData(movieDetailsData: self.movieDetailsDataArray ?? [])
//                }
//            } catch {
//
//            }
//        }) { (error) in
//            self.fetchCredits()
//        }
//    }
    
    //Function to fetch credits for the movie detail screen
    func fetchCredits() {
        
        if reachability.currentReachabilityStatus == .notReachable {
            return
        }
        
        let params = [
            "api_key" : APIConstants.APP_API_KEY,
            "language" : APIConstants.APP_SERVICE_LANGUAGE,
            ] as [String : Any]
        
        let methodName = "\(id)/\(WebServiceMethods.WS_CREDITS)"
        
        APIRequest().callGetService(methodName: methodName, params: params, successBlock: { (data) in
            do {
                let creditsResponse = try self.jsonDecoder.decode(MovieCreditResponse.self, from: data)
                
                //If the data is present then only adding it to the tableview cell
                if creditsResponse.cast?.count ?? 0 > 0 {
                    self.movieDetailsDataArray?.append(MovieDetailsSection(type: .credits, data: creditsResponse))
                }
                
                self.fetchSimilarData()
                
                DispatchQueue.main.async {
                    self.delegate?.didFetchedData(movieDetailsData: self.movieDetailsDataArray ?? [])
                }
            } catch {
                
            }
        }) { (error) in
            self.fetchSimilarData()
        }
    }
    
    //Function to fetch similar movies for the movie detail screen
    func fetchSimilarData() {
        
        if reachability.currentReachabilityStatus == .notReachable {
            return
        }
        
        let params = [
            "api_key" : APIConstants.APP_API_KEY,
            "language" : APIConstants.APP_SERVICE_LANGUAGE,
            ] as [String : Any]
        
        let methodName = "\(id)/\(WebServiceMethods.WS_SIMILAR)"

        APIRequest().callGetService(methodName: methodName, params: params, successBlock: { (data) in
            do {
                let similarDataResponse = try self.jsonDecoder.decode(MovieSimilarResponse.self, from: data)

                //If the data is present then only adding it to the tableview cell
                if similarDataResponse.results?.count ?? 0 > 0 {
                    self.movieDetailsDataArray?.append(MovieDetailsSection(type: .similar, data: similarDataResponse))
                }
                
                self.fetchVideos()
                
                DispatchQueue.main.async {
                    self.delegate?.didFetchedData(movieDetailsData: self.movieDetailsDataArray ?? [])
                }
                
            } catch {
                
            }
        }) { (error) in
            self.fetchVideos()
        }
    }
    
    //Function to fetch credits for the movie detail screen
       func fetchVideos() {
           
           if reachability.currentReachabilityStatus == .notReachable {
               return
           }
           
           let params = [
               "api_key" : APIConstants.APP_API_KEY,
               "language" : APIConstants.APP_SERVICE_LANGUAGE,
               ] as [String : Any]
           
           let methodName = "\(id)/\(WebServiceMethods.WS_VIDEOS)"
           
           APIRequest().callGetService(methodName: methodName, params: params, successBlock: { (data) in
               do {
                   let creditsResponse = try self.jsonDecoder.decode(MovieVideoResponse.self, from: data)
                   
                   //If the data is present then only adding it to the tableview cell
                   if creditsResponse.movies?.count ?? 0 > 0 {
                       self.movieDetailsDataArray?.append(MovieDetailsSection(type: .videos, data: creditsResponse))
                   }
                   
                   
                   DispatchQueue.main.async {
                       self.delegate?.didFetchedData(movieDetailsData: self.movieDetailsDataArray ?? [])
                   }
               } catch {
                   
               }
           }) { (error) in

            }
       }
}
