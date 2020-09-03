//
//  APIConstants.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation

//Keys frequently used in app
struct APIConstants {
    
    static let APP_API_KEY = "a40d62d3a40793c9176e7bfa233985bb"
    static let APP_SERVICE_LANGUAGE = "en-US"
}

//Web service Base URL's and Methods
struct WebServiceMethods {
    
    static let WS_BASE_URL = "https://api.themoviedb.org/3/movie/"
    static let WS_IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    static let WS_IMAGE_YOUTUBE_URL = "https://img.youtube.com/vi/"
    static let WS_VIDEO_YOUTUBE_URL = "https://www.youtube.com/watch?v="
    
    static let WS_NOW_PLAYING = "now_playing"
    static let WS_VIDEOS = "videos"
    static let WS_CREDITS = "credits"
    static let WS_SIMILAR = "similar"

 
}
