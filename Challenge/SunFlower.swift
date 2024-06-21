//
//  SunFlower.swift
//  Challenge
//
//  Created by Omid Shojaeian Zanjani on 10/02/24.
//


import SwiftUI

struct SunFlower: View {
    @State private var seeds: Double = 100.0
    
    var body: some View {
            VStack {
                SunflowerView(seeds: Int(seeds))
                    .background(Color.red)
                    //.frame(width: 400, height: 400)
                
                Text("Showing \(Int(seeds)) seeds")
                
                Slider(value: $seeds, in: 20...6000, step: 1)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
            .padding()
        Spacer()
    }
}


let primaryColor = Color.orange

struct SunflowerView: View {
    static let seedRadius: CGFloat = 2.0
    static let scaleFactor: CGFloat = 4.0
    static let tau = 2 * Double.pi
    static let phi = (sqrt(5) + 1) / 2
    
    var seeds: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.seeds, id: \.self) { i in
                    let theta = Double(i) * Self.tau / Self.phi
                    let r = sqrt(Double(i)) * Self.scaleFactor
                    let x = geometry.size.width / 2 + CGFloat(r * cos(theta))
                    let y = geometry.size.height / 2 - CGFloat(r * sin(theta))
                    
                    if geometry.frame(in: .local).contains(CGPoint(x: x, y: y)) {
                        self.drawSeed(at: CGPoint(x: x, y: y))
                    }
                }
            }
            .drawingGroup()
        }
        .navigationBarTitle("Sunflower")
    }
    
    private func drawSeed(at point: CGPoint) -> some View {
        Circle()
            .foregroundColor(primaryColor)
            .frame(width: Self.seedRadius * 2, height: Self.seedRadius * 2)
            .position(point)
    }
}

#Preview {
    SunFlower()
}

