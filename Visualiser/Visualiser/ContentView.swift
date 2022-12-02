//
//  ContentView.swift
//  Visualiser
//
//  Created by Avid Fayaz on 2022-12-01.
//

import SwiftUI
import Charts

//array to get the party started
//used throughout whole code
struct ContentView: View {
    var input: [Int] {
        var array = [Int]()
        for i in 1...30{
            array.append(i)
        }
        
        return array.shuffled()
        
    }
    
    //wrapper to allow us to modify values inside a struct
    //moves data into shared storage
    @State var data = [Int]()
    @State var active_value = 0
    @State var next_value = 0
    @State var after_show: Int? // if it has been sorted make give a nice show to the viewer
    
    var body: some View {
        VStack {
            Chart{
                ForEach(Array(zip(data.indices, data)), id: \.0) {index, item in
                    BarMark(x: .value("Position", index), y: .value("value", item))
                        .foregroundStyle(getColor(value: item).gradient)
                }
                    
            }
            .frame(width:300, height:260)
            
            
            //Bubble button
            Button {
                Task{
                    try await bubble_sort()
                    active_value = 0
                    next_value = 0
                    
                    for index in 0..<data.count {
                        after_show = data[index]
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
                    }
                }
            }
            label: {
            Text("Bubble it up!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
            
            
            //selection button
            Button {
                Task{
                    try await selection_sort()
                    active_value = 0
                    next_value = 0
                    
                    for index in 0..<data.count {
                        after_show = data[index]
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
                    }
                }
            }
            label: {
            Text("Selection sort it!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
            
            
            //Insertion sort
            Button {
                Task{
                    try await insertion_sort()
                    active_value = 0
                    next_value = 0
                    
                    for index in 0..<data.count {
                        after_show = data[index]
                        try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
                    }
                }
            }
            label: {
            Text("Insertion sort it!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
bsghaf
            
        }
        
        .onAppear {
            data = input
        }

    }
    
    //Lets bubble some sh#@t up
    func bubble_sort() async throws{
        guard data.count > 1
        else{
            return
        }
        
        for i in 0..<data.count {
            
            for j in 0..<data.count - i - 1 {
                
                active_value = data[j]
                next_value = data[j + 1]
                
                if data[j] > data[j + 1] {
                    data.swapAt(j + 1, j)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
                }
            }
        }
    }
    
    
    //selection sort
    func selection_sort() async throws{
        guard data.count > 1
        else {
            return
        }
        
        for i in 0..<data.count - 1 {
            var smallest = i
            
            for j in i + 1..<data.count {
                if data[smallest] > data [j] {
                    active_value = data[j]
                    smallest = j
                    
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
                    
                }
            }
            
            if smallest != i {
                active_value = data[smallest]
                next_value = data[i]
                data.swapAt(smallest, i)
                try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
            }
            
        }
    }
    
    
    //Insertion sort
    func insertion_sort() async throws {
        guard data.count > 1
        else {
            return
        }
        
        for i in 1..<data.count {
            for j in (1...i).reversed() {
                if data[j] < data [j - 1]{
                    active_value = data[j - 1]
                    next_value = data[j]
                    data.swapAt(j, j - 1)
                    
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(69)), clock: .continuous) //;D
                    
                }
                else{
                    break
                }
            }
        }
        
    }
    
    
    
    
    
    func getColor(value: Int) -> Color {
        
        if let after_show, value <= after_show {
            return .green
        }
            
        if value == next_value {
            return .green
        }
        else if value == active_value {
            return .red
        }
        return .blue
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
