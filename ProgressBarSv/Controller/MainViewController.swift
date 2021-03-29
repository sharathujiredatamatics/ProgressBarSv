//
//  ViewController.swift
//  ProgressBarSv
//
//  Created by Datamatics on 26/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
import SVProgressHUD
import Photos
class MainViewController: UIViewController {
    @IBOutlet weak var downloadVideo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        DownloadData.shared.parseSongs()
    }
    
    @IBAction func downLoadVideoButton(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: "\nDownloading Video")
        let sampleURL = DownloadLinks.shared.link2
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: sampleURL), let urlData = NSData(contentsOf: url) {
                let galleryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(galleryPath)/videoName.mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL:
                            URL(fileURLWithPath: filePath))
                    }) {
                        success, error in
                        if success {
                            print("Succesfully Saved")
                            SVProgressHUD.showSuccess(withStatus: "Video Downloaded and Saved to Gallery")
                            //                            SVProgressHUD.dismiss()
                        } else {
                            print(error?.localizedDescription as Any)
                            SVProgressHUD.showError(withStatus: "\nDownload Failed")
                            //                            SVProgressHUD.dismiss()
                            
                        }
                    }
                }
            }
            else{
                SVProgressHUD.showError(withStatus: "\nDownload Failed")
            }
        }
    }
}

