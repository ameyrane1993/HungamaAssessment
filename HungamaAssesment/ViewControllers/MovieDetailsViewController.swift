//
//  MovieDetailsViewController.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    var movieDetailsDataArray : [MovieDetailsSection] = []
    var movieDetails: MovieResults?
    let reachability = Reachability()!
    var presenter: MovieDetailsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        //UITableview setup
        setupTableviewCells()

        //Registering cells
        registerCells()
        
        //Fetch data for the details screen
        presenter = MovieDetailsPresenter(movieID: "\(movieDetails?.id ?? 0)")
        presenter?.delegate = self
        
        //fetching data
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = movieDetails?.title ?? ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    func registerCells() {
        movieDetailsTableView.register(UINib(nibName: "MoviePosterTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviePosterTableViewCell")
        movieDetailsTableView.register(UINib(nibName: "MovieSynopsisTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieSynopsisTableViewCell")
        movieDetailsTableView.register(UINib(nibName: "MovieVideosTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieVideosTableViewCell")
        movieDetailsTableView.register(UINib(nibName: "MovieCreditsTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCreditsTableViewCell")
        movieDetailsTableView.register(UINib(nibName: "SimilarMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SimilarMoviesTableViewCell")
        
    }
    
    func setupTableviewCells(){
        movieDetailsTableView.rowHeight = UITableView.automaticDimension
        movieDetailsTableView.estimatedRowHeight = 180
        movieDetailsTableView.tableFooterView = UIView()
    }
    
    func fetchData(){
        //Adding movie poster as the first object in array to be displayed on top
        movieDetailsDataArray.append(MovieDetailsSection(type: .poster, data:movieDetails))
        
        //calling apis to fetch data
        presenter?.fetchSynopsis(movieDetailsDataArray: movieDetailsDataArray)
    }
    
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailsDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellType = movieDetailsDataArray[indexPath.row].type  {
            
            //Displaying data on the basis of cell type assigned to each on the details fecth
            switch cellType {
            case .poster :
                let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePosterTableViewCell", for: indexPath) as! MoviePosterTableViewCell
                cell.selectionStyle = .none
                
                cell.moviePosterImageView.loadImage(movieDetails?.backdrop_path ?? "", type: .original)
                
                return cell
                
            case .synopsis:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSynopsisTableViewCell", for: indexPath) as! MovieSynopsisTableViewCell
                cell.selectionStyle = .none
                
                let synopsisData = movieDetailsDataArray[indexPath.row].data as? MovieSynopsisResponse
                
                cell.movieNameLabel.text = synopsisData?.title ?? ""
                cell.movieReleaseDateLabel.text = synopsisData?.release_date ?? ""
                
                let genreString = synopsisData?.genres?.reduce("", { (result: String, genre: Genres) -> String in
                    if result == "" {
                        return (genre.name ?? "")
                    } else {
                        return result + ", " + (genre.name ?? "")
                    }
                })
                
                cell.movieGenreLabel.text = genreString ?? ""
                
                let languagesString = synopsisData?.spoken_languages?.reduce("", { (result: String, language: Spoken_languages) -> String in
                    if result == "" {
                        return (language.name ?? "")
                    } else {
                        return result + ", " + (language.name ?? "")
                    }
                })
                
                cell.movieLanguageLabel.text = languagesString ?? ""
                cell.movieDescriptionLabel.text = synopsisData?.overview ?? ""
                
                return cell
                
            case .videos:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieVideosTableViewCell", for: indexPath) as! MovieVideosTableViewCell
                cell.selectionStyle = .none
                
                cell.data = movieDetailsDataArray[indexPath.row].data as? MovieVideoResponse
                
                return cell
                
            case .credits:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCreditsTableViewCell", for: indexPath) as! MovieCreditsTableViewCell
                cell.selectionStyle = .none
                
                cell.data = movieDetailsDataArray[indexPath.row].data as? MovieCreditResponse
                
                return cell
                
            case .similar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMoviesTableViewCell", for: indexPath) as! SimilarMoviesTableViewCell
                cell.selectionStyle = .none
                
                cell.data = movieDetailsDataArray[indexPath.row].data as? MovieSimilarResponse
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
            cell!.backgroundColor = .lightGray
            
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK:- Presenter Delegate

extension MovieDetailsViewController: MovieDetailsPresenterDelegate {
    func didFetchedData(movieDetailsData: [MovieDetailsSection]) {
        self.movieDetailsDataArray = movieDetailsData
            self.movieDetailsTableView.reloadData()
    }
}
