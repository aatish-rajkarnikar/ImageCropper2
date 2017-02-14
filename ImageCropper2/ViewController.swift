//
//  ViewController.swift
//  ImageCropper2
//
//  Created by Aatish Rajkarnikar on 2/14/17.
//  Copyright © 2017 Aatish Rajkarnikar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageViewWidth: NSLayoutConstraint!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setImageToCrop(image: UIImage(named: "deadpool")!)
        
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setImageToCrop(image:UIImage){
        imageView.image = image
        imageViewWidth.constant = image.size.width
        imageViewHeight.constant = image.size.height
        let scaleHeight = scrollView.frame.size.width/image.size.width
        let scaleWidth = scrollView.frame.size.height/image.size.height
        scrollView.minimumZoomScale = max(scaleWidth, scaleHeight)
        scrollView.zoomScale = max(scaleWidth, scaleHeight)
    }
    
    @IBAction func cropButtonPressed(_ sender: Any) {
        let scale:CGFloat = 1/scrollView.zoomScale
        let x:CGFloat = scrollView.contentOffset.x * scale
        let y:CGFloat = scrollView.contentOffset.y * scale
        let width:CGFloat = scrollView.frame.size.width * scale
        let height:CGFloat = scrollView.frame.size.height * scale
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: CGRect(x: x, y: y, width: width, height: height))
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        setImageToCrop(image: croppedImage)
    }
    

}

