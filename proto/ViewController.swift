//
//  ViewController.swift
//  proto
//
//  Created by 竹内秀樹 on 2017/09/28.
//  Copyright © 2017年 hideki.takeuchi. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire // Alamofireをimport
import SwiftyJSON // SwiftyJSONをimport


class ViewController: UIViewController {
    
    var googleMap : GMSMapView!
    
    //緯度経度 -> 金沢駅
    let latitude: CLLocationDegrees = 36.5780574
    let longitude: CLLocationDegrees = 136.6486596

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ズームレベル.
        let zoom: Float = 15
        
        // カメラを生成.
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude,longitude: longitude, zoom: zoom)
        
        // MapViewを生成.
        googleMap = GMSMapView(frame: CGRect(x:0, y:0, width:self.view.bounds.width, height:self.view.bounds.height))
        
        // MapViewにカメラを追加.
        googleMap.camera = camera
        
        //マーカーの作成
        let marker: GMSMarker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.map = googleMap
        
        
        //viewにMapViewを追加.
        self.view.addSubview(googleMap)
        
        //試しにぐるなびAPI実行
        getStores()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStores() {
        // ぐるなびAPIへリクエストを送信
        Alamofire.request(.GET, "https://api.gnavi.co.jp/RestSearchAPI/20150630/")
            .responseJSON{response in
                print(response.result.value) // responseのresultプロパティのvalueプロパティをコンソールに出力
    }


}

