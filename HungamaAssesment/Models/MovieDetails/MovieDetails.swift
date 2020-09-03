//
//  MovieDetails.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation

enum MovieDetailCellType {
    case poster
    case synopsis
    case videos
    case credits
    case similar
}

struct MovieDetailsSection {

    var type: MovieDetailCellType?
    var data: Any?
    
    init(type: MovieDetailCellType, data: Any?) {
        self.type = type
        self.data = data
    }
}
