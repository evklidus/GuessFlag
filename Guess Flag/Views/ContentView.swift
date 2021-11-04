//
//  ContentView.swift
//  Guess Flag
//
//  Created by Erik Minasov on 22.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var countriesAndStates = ["Argentina" : "Buenos Aires", "USA" : "Washington", "UK" : "London", "Greece" : "Greece", "Russia" : "Moscow", "Brazil" : "Brazil", "Bangladesh" : "Dhaka", "Canada" : "Ottawa", "Germany" : "Berlin", "Sweden" : "Stockholm"]
    @State private var countries = ["Argentina", "USA", "UK", "Greece", "Russia", "Brazil", "Bangladesh", "Canada", "Germany", "Sweden"].shuffled()
    //@State private var capital = ["Buenos Aires", "Washington", "London", "Greece", "Moscow", "Brazil", "Dhaka", "Ottawa", "Berlin", "Stockholm"].shuffled()
    @State private var currectAnswer = Int.random(in: 0...2) //просто рандомное число от 0 до 2
    @State private var currentState = "Brazil"
    
    @State private var score = 0
    @State private var showingScoreAlert = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all) // игнорирует safe area и заполняется весь экран
            VStack(spacing: 40) {
                VStack {
                    Text("Выберите флаг: ")
                        .foregroundColor(.white)
                        .font(.title2)
                    Text(countriesAndStates[currentState]!)
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                }
                
                ForEach(0..<3) { flagNumber in
                    Button( action: {
                        self.flagTapped(flagNumber: flagNumber)
                        self.showingScoreAlert = true
                    }) {
                        VStack {
                            
                            Image(self.countries[flagNumber])
                            
                            Text("\(self.countries[flagNumber])")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                }
                Text("Общий счет: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }
        .onAppear() {
            
            currentState = countries[currectAnswer]
        }
        
        .alert(isPresented: $showingScoreAlert) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")) {
                self.askQuestion()
            })
        }
    }
    
    
    
    func askQuestion() {
        countries.shuffle()
        currectAnswer = Int.random(in: 0...2)
        currentState = countries[currectAnswer]
    }
    
    func flagTapped(flagNumber: Int) {
        if flagNumber == currectAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[flagNumber])"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
