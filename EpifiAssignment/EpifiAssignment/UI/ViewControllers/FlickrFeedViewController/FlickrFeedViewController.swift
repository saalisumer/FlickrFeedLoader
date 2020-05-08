//
//  FlickrFeedViewController.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit

final class FlickrFeedViewControllerComposer{
    static func getInstance() -> FlickrFeedViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier:String(describing: FlickrFeedViewController.self)) as! FlickrFeedViewController
        let feedViewModel = FlickrFeedViewModel(flickrRequest: RequestUtil.getFlickrRequest())
        vc.feedRefreshController = FlickrFeedRefreshController(flickrFeedViewModel: feedViewModel)
        return vc
    }
}

class FlickrFeedViewController:UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    var feedRefreshController:FlickrFeedRefreshController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFeedRefreshConrroller()
        self.feedRefreshController?.load()
    }
    
    private func setupFeedRefreshConrroller(){
        self.feedRefreshController?.collectionView = self.collectionView
        self.feedRefreshController?.onSelect = { item in
            let detailViewController = FeedDetailViewControllerComposer.getInstance(item: item)
            self.present(detailViewController, animated: true, completion: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
}
