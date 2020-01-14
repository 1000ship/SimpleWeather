//
//  ContentView.swift
//  SimpleWeather
//
//  Created by 천성혁 on 2020/01/14.
//  Copyright © 2020 1000ship. All rights reserved.
//

import SwiftUI
import CoreFoundation

struct ContentView: View {
    
    @State var temp : String = ""
    @State var wind : String = ""
    @State var humi : String = ""
    
    func getBeside( str : String, from : String, to : String, index : Int = 0 ) -> String
    {
        var tmp = str.components(separatedBy: from)[1+index]
        tmp = tmp.components(separatedBy: to)[0]
        return tmp
    }
    
    func loadWeather ( ) -> Void {
        do {
            let url = URL(string: "http://www.weather.go.kr/weather/forecast/timeseries.jsp")!
            let data = try Data(contentsOf: url)
            let html = String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding( 0x0422 )))!
            let partial = getBeside(str: html, from: "<div class=\"local_forecast_inn\">", to: "_<>_<>_")
            temp = getBeside(str: partial, from: "<dd class=\"now_weather1_center temp1 MB10\">", to: "</dd>")
            wind = getBeside(str: partial, from: "<dd class=\"now_weather1_center\">", to: "</dd>")
            humi = getBeside(str: partial, from: "<dd class=\"now_weather1_center\">", to: "</dd>", index: 1)
        }
        catch
        {
            print("error")
        }
    }
    
    var body: some View {
        VStack() {
            Text("Today's Weather")
                .font(.title)
                .fontWeight(.thin)
            Text("\(temp)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 20.0)
            
            Text("풍속 \(wind)")
                .font(.title)
                .fontWeight(.medium)
            }
                
            Text("습도 \(humi)")
                .font(.title)
                .fontWeight(.medium)
            Text("Have a nice day")
                .font(.footnote)
                .fontWeight(.ultraLight)
                .padding(.top, 50.0)
                
        }
        .onAppear(perform: loadWeather)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
