//
//  MoviesCollectionViewController.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {
    
    let client = TraktClient()
    
    let refreshControl = UIRefreshControl()
    
    var moviesDatasource = [Show]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createRefreshControl()
        
        refreshMovies()
    }
    
    /// Mark - CollectionView DataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesDatasource.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = "ShowCell"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowCustomCell
        cell.backgroundColor = UIColor.blackColor()
        
        let show = self.moviesDatasource[indexPath.row]
        
        cell.loadCellForObject(show)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 0.0, left: 20.0, bottom: 20.0, right: 20.0)
    }
    
    /// Mark - Refresh Control
    func createRefreshControl(){
        
        self.refreshControl.addTarget(self, action: Selector("refreshMovies"), forControlEvents: .ValueChanged)
        self.collectionView?.addSubview(self.refreshControl)
        
    }
    
    func refreshMovies() {
    
        self.refreshControl.beginRefreshing()
        
        client.getMovies { shows in
            self.moviesDatasource = shows
            
            self.collectionView?.reloadData()
            
            self.refreshControl.endRefreshing()
        }
    }
    

    

}