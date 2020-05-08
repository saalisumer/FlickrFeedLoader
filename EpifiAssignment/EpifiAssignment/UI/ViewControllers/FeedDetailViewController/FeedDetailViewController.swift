//
//  FeedDetailViewController.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 09/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class FeedDetailViewControllerComposer{
    static func getInstance(item:FlickrItemViewModel) -> FeedDetailViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier:String(describing: FeedDetailViewController.self)) as! FeedDetailViewController
        vc.flickrItemViewModel = item
        return vc
    }
}

class FeedDetailViewController:UIViewController{
    var flickrItemViewModel:FlickrItemViewModel?
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var authorNameLabel:UILabel!
    @IBOutlet weak var dateTakenLabel:UILabel!
    @IBOutlet weak var linkButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView(){
        if let url = flickrItemViewModel?.getImageURL(){
            self.imageView.af_setImage(withURL: url)
        }
        
        self.titleLabel.text = self.flickrItemViewModel?.getTitleLabel()
        self.authorNameLabel.text = self.flickrItemViewModel?.getAuthorName()
        self.dateTakenLabel.text = self.flickrItemViewModel?.getDateTaken()
        self.linkButton.setTitle(self.flickrItemViewModel?.getLink(), for: .normal)
    }
    
    @IBAction func didTapLink(){
        if let url = URL(string:self.flickrItemViewModel?.getLink() ?? ""){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
