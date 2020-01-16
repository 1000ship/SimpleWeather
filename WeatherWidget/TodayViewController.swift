//
//  TodayViewController.swift
//  WeatherWidget
//
//  Created by 천성혁 on 2020/01/15.
//  Copyright © 2020 1000ship. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreFoundation

class TodayViewController: UIViewController, NCWidgetProviding {

    
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var windText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tempText.text = ""
        windText.text = ""
    }
    
    private func getBeside( str : String, from : String, to : String, index : Int = 0 ) -> String
    {
        var tmp = str.components(separatedBy: from)[1+index]
        tmp = tmp.components(separatedBy: to)[0]
        return tmp
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        do {
            let url = URL(string: "http://www.weather.go.kr/weather/forecast/timeseries.jsp")!
            let data = try Data(contentsOf: url)
            let html = String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding( 0x0422 )))!
            let partial = getBeside(str: html, from: "<div class=\"local_forecast_inn\">", to: "_<>_<>_")
            let temp = getBeside(str: partial, from: "<dd class=\"now_weather1_center temp1 MB10\">", to: "</dd>")
            let wind = getBeside(str: partial, from: "<dd class=\"now_weather1_center\">", to: "</dd>")
//            humi = getBeside(str: partial, from: "<dd class=\"now_weather1_center\">", to: "</dd>", index: 1)
            
            tempText.text = temp
            windText.text = wind
        }
        catch
        {
            print("error")
        }
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
