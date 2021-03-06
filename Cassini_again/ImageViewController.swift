//
//  ImageViewController.swift
//  Cassini_again
//
//  Created by minsoo kim on 2018. 10. 6..
//  Copyright © 2018년 minsoo kim. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate  {
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil{
                fetchImage()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil{
            fetchImage()
        }
    }
    
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    
    func fetchImage(){
        if let url = imageURL{
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents{
                image = UIImage(data: imageData)
            }
        }
    }

    var imageView = UIImageView()
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
}
