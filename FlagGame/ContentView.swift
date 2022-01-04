//
//  ContentView.swift
//  FlagGame
//
//  Created by franklin melo on 27/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var alertTitle = ""
    @State private var showAlert = false
    @State private var message = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: .indigo, location: 0.3),
                                   .init(color: .purple, location: 0.4)],
                           center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(contries[correctAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(contries[number])
                                .renderingMode(.original)
                                .shadow(radius: 10)
                                .clipShape(Capsule())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    score = 0
                } label: {
                    Label("Reset", systemImage: "trash")
                        .foregroundColor(.white)
                        .font(.body.weight(.heavy))
                }
                .frame(width: 120, height: 50, alignment: .center)
                .background(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Play Again", action: playAgain)
        } message: {
            Text(message)
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            message = "You score is \(score)"
            alertTitle = "Correct"
        } else {
            message = "The selected flag is \(contries[number])"
            alertTitle = "Wrong"
        }
        showAlert = true
    }
    
    private func playAgain() {
        contries = contries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
