//
//  ContentView.swift
//  SimpleWeather
//
//  Created by 천성혁 on 2020/01/14.
//  Copyright © 2020 1000ship. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Today's Weather")
                    .font(.title)
                    .fontWeight(.thin)
                
            }
        }.navigationBarTitle("Simple Weather")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
