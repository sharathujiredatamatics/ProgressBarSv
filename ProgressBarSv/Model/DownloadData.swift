//
//  DownloadData.swift
//  ProgressBarSv
//
//  Created by Datamatics on 29/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//
import UIKit
struct Songs : Decodable {
    let songName : String
    let link : String
}
class DownloadData{
    static let shared = DownloadData()
    init() {
    }
    var songs = [Songs]()
    func parseSongs() {
        let url = Bundle.main.path(forResource:"songs", ofType: "json")!
        let jsondata = try! Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
        self.songs = try! JSONDecoder().decode([Songs].self, from: jsondata)
    }
}

