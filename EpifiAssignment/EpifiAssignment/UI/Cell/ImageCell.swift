//
//  ImageCell.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 09/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
class ImageCell:UICollectionViewCell{
    @IBOutlet weak var imageView:UIImageView!
    var flickrItemViewModel:FlickrItemViewModel?{
        didSet{
            if let _ = flickrItemViewModel{
                self.configure()
            }
            else{
                self.clear()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = 1.0
        self.imageView.clipsToBounds = true
    }
    
    private func configure(){
        if let imageURL = self.flickrItemViewModel?.getImageURL() {
            self.imageView.af_setImage(withURL: imageURL)
        }
    }
    
    private func clear(){
        self.imageView.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.clear()
    }
}
