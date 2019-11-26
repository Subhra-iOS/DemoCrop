//
//  ViewController.swift
//  DemoImageResize
//
//  Created by Subhra Roy on 17/11/19.
//  Copyright © 2019 Subhra Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoImageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var demoRoundRectView: SRRoundRectView!
    private var imageViewWidth : CGFloat = UIScreen.main.bounds.size.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        changeImageInUI()
    }
    
    private func isCurrentDeviceIpad() -> Bool{
               return UIDevice().userInterfaceIdiom == .pad
    }

    func getBannerImagePath()  -> String{
        
        let paths: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var path: String = paths.appendingFormat("/ImageFolder")
        
            _ =  createDirectoryIfNecessaryForPath(path: path)
            
            path = path.appending("/Banner.jpg")
            return  path
    }
    
    internal func createDirectoryIfNecessaryForPath(path : String)  -> Bool {
        
        if !FileManager.default.fileExists(atPath: path) {
        
            do{
            
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: [:])
                
                return true
            
            }catch{
            
                 print("Error")
            }
            
        }else{
    
            return true
        }
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.all
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)   {
        
            changeImageInUI()
      }
    
    private func changeImageInUI() -> Void{
        
         let path : String = self.getBannerImagePath()
         print("Image_path : \(path)")
         if FileManager.default.fileExists(atPath: path){
             do{
                 try FileManager.default.removeItem(at: URL(fileURLWithPath: path))
             }catch{
                 
             }
         }
         
        let demoImage = UIImage(named: "ipad-banner-2")
       
        let screenSize : CGSize = UIScreen.main.bounds.size

        print("\(screenSize)")
        print("\(self.imageViewWidth)")

         self.imageViewWidth = screenSize.width
         let finalWidth =  self.imageViewWidth
         
        let imageData = demoImage?.resizeImage(viewWidth: finalWidth)
         let  modifiedImage : UIImage = (imageData?.newImage)!
         let imageViewHeight = imageData?.newHeight
                
                if let imageData : Data = modifiedImage.jpegData(compressionQuality: 0.0) {
                    let path : String = self.getBannerImagePath()
                    do{
                        try imageData.write(to: URL(fileURLWithPath: path))
                    }catch{
                        
                    }
                 
                 DispatchQueue.main.async { [weak self] in
                     self?.demoImageView.image = nil
                     self?.imageViewHeight.constant = imageViewHeight!
                     self?.demoImageView.image = UIImage(data: imageData)
                 }
                    
                }
    }
    
}

