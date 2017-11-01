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
 
    
    let params: Parameters = ["keyid": gru_key,"format": "json","area": "AREA110"]

    
    
    //緯度経度 -> 金沢駅
    let latitude: CLLocationDegrees = 36.5780574
    let longitude: CLLocationDegrees = 136.6486596

    /// <#Description#>
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

    //            Alamofire.request("https://api.gnavi.co.jp/RestSearchAPI/20150630/get", parameters: parameters).responseJSON { response in
        Alamofire.request("https://api.gnavi.co.jp/RestSearchAPI/20150630/", method: .get, parameters: params).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        // ぐるなびAPIへリクエストを送信
      //  Alamofire.request(.GET, "https://api.gnavi.co.jp/RestSearchAPI/20150630/")
       //     .responseJSON{response in
        //        print(response.result.value) // responseのresultプロパティのvalueプロパティをコンソールに出力
       // }
    }


}
