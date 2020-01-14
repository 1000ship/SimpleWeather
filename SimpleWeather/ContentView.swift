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
    
    @State var temp : String = "               "
    @State var wind : String = "               "
    @State var humi : String = "               "
    @State var loaded : Bool = false
    
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
            self.loaded = true
        }
        catch
        {
            print("error")
        }
    }
    
    var body: some View {
        
        VStack() {
            
            Spacer()
            
            Text("Today's Weather")
                .font(.title)
                .fontWeight(.thin)
            
            Text("\(temp)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top, 20.0)
                .offset(x: 0, y: CGFloat(self.loaded ? 0 : 5))
                .opacity(self.loaded ? 1 : 0 )
                .animation(Animation.easeInOut(duration: 0.25))
                
            
            Text("풍속 \(wind)")
                .font(.title)
                .fontWeight(.medium)
                .offset(x: 0, y: CGFloat(self.loaded ? 0 : 5))
                .opacity(self.loaded ? 1 : 0 )
                .animation(Animation.easeInOut(duration: 0.25).delay(0.05))
                
                
            Text("습도 \(humi)")
                .font(.title)
                .fontWeight(.medium)
                .offset(x: 0, y: CGFloat(self.loaded ? 0 : 5))
                .opacity(self.loaded ? 1 : 0 )
                .animation(Animation.easeInOut(duration: 0.25).delay(0.1))
            
            Text("Have a nice day")
                .font(.footnote)
                .fontWeight(.ultraLight)
                .padding(.top, 50.0)
            
            Spacer()
            
            Button(action: reloadWeather){
                Text("Reload Weather")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30.0)
                    .padding(.vertical, 10.0)
                    .background(Color.blue)
            }
            .cornerRadius(10)
            .padding(.bottom, UIScreen.main.bounds.height * 0.08)
            .opacity(self.loaded ? 1 : 0 )
            .offset(x: 0, y: CGFloat(self.loaded ? 0 : UIScreen.main.bounds.height * 0.1 ))
            .animation(Animation.easeInOut(duration: 0.3))
        
        }
        .onAppear(perform: loadWeather)
    }
    
    func reloadWeather (){
        if self.loaded {
            self.loaded = false
            let time = DispatchTime.now() + .milliseconds(650)
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.loadWeather()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
