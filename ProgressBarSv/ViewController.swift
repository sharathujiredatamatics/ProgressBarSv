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
class ViewController: UIViewController {
    @IBOutlet weak var downloadVideo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func downLoadVideoButton(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: "\nDownloading Video")
        let sampleURL = "http://159.65.154.78:8002/storage/whatsapp-status/video/2018/07/26/Zd1XMyCZIpd3XHREyWFOou9ig98IzcJKxEYR8fzd.mp4"
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

