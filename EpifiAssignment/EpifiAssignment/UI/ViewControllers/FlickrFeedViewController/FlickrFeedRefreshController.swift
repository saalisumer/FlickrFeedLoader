//
//  FlickrFeedRefreshController.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 09/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit

class FlickrFeedRefreshController:NSObject{
    let padding:CGFloat = 10.0
    private var refreshControl:UIRefreshControl?
    var collectionView:UICollectionView?{
        didSet{
            if let collectionView = collectionView{
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ImageCell.self))
                (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width:0,height:0)
                collectionView.contentInset = UIEdgeInsets(top: self.padding, left: 0, bottom: self.padding, right: 0)
                addPullRefreshControlUI()
            }
        }
    }
    
    let feedViewModel:FlickrFeedViewModel
    init(flickrFeedViewModel:FlickrFeedViewModel){
        feedViewModel = flickrFeedViewModel
        super.init()
        bind()
    }
    
    func load(clear:Bool = false){
        self.feedViewModel.load(clear:clear)
    }
    
    var onSelect:((FlickrItemViewModel)->())?
    
    private func addPullRefreshControlUI(){
        refreshControl = UIRefreshControl()
        refreshControl!.tintColor = UIColor.red
        refreshControl!.addTarget(self, action: #selector(refreshNow(refreshControl:)), for: .valueChanged)
        collectionView!.refreshControl = refreshControl
        collectionView!.addSubview(refreshControl!)
    }
    
    @objc private func refreshNow(refreshControl:UIRefreshControl){
        refreshControl.beginRefreshing()
        self.load(clear: true)
    }
    
    
    private func refreshView(){
        self.collectionView?.reloadData()
    }
    
    private func showError(error:Error){
        if let collectionView = collectionView{
            showToast(error.localizedDescription, on: collectionView)
        }
    }
    
    private func bind(){
        self.feedViewModel.onLoadFinished = {[weak self] result in
            guard let self = self else { return }
            runAsyncOnMainQueue {
                switch result{
                    case .success:
                        self.refreshView()
                    case let .failure(error):
                        self.showError(error: error)
                }
                self.refreshControl!.endRefreshing()
            }
        }
    }
}

extension FlickrFeedRefreshController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedViewModel.flickrItemsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImageCell{
            cell.flickrItemViewModel = self.feedViewModel.flickrItemsViewModel[indexPath.item]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImageCell{
            cell.flickrItemViewModel = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - self.padding)/2.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FlickrFeedRefreshController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let onSelect = self.onSelect{
            onSelect(self.feedViewModel.flickrItemsViewModel[indexPath.item])
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height - 50 {
            self.feedViewModel.load()
        }
    }
}
