//
//  ContentView.swift
//  SwiftUIGuessTheFlag
//
//  Created by Никита on 08.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 0
    @State private var showingFinal = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia",  "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            
            RadialGradient(stops: [
                .init(color: .mint, location: 0.26),
                .init(color: .cyan, location: 0.26)
            ], center: .top, startRadius: 200, endRadius: 500)
                .ignoresSafeArea()
            
            VStack (spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("Final", isPresented: $showingFinal) {
            Button("Restart game", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            gameCount += 1
        } else {
            scoreTitle = "Wrong, thats a flag of \(countries[number])"
            score -= 1
            gameCount += 1
        }
        
        if gameCount < 8 {
            showingScore = true
        } else if gameCount == 8 {
            showingFinal = true
        }
        
    }
    
    func resetGame(){
        countries.shuffle()
        score = 0
        gameCount = 0
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
