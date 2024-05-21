//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Жанибек Асылбек on 14.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var isReached8 = false
    @State private var scoreTitle = ""
    @State private var scoreCounter = 0
    @State private var counter = 0
    @State private var animationAmount = 0.0
    
    

    
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                LinearGradient(colors: [.yellow, .green], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
//                LinearGradient(colors: [.green, .green], startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
//                AngularGradient(gradient: Gradient(stops: [
//                            .init(color: Color.red, location: 0.0),
//                            .init(color: Color.green, location: 0.5)
//                        ]), center: .center)
//                .ignoresSafeArea()
            }
            
            VStack{
                
                Spacer()
                
                Text("Guess the Country")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.semibold))
                
                Spacer()
                
                VStack(spacing: 30){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .setImage()
                        }
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: 341)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
               
                Spacer()
                
                Text("Your Score: \(scoreCounter)")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.semibold))
                
                Spacer()
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button ("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreCounter)!")
        }
        .alert("The End!", isPresented: $isReached8){
            Button("Reset", action: reset)
        } message: {
            Text("You had \(scoreCounter) right answers out of 8")
        }
    }
  
    func flagTapped(_ number: Int) {
        withAnimation{
            animationAmount += 360
        }
        
        if number == correctAnswer{
            scoreTitle = "Correct!"
            scoreCounter += 1
        }else{
            scoreTitle = "Wrong :(, that's the flag of \(countries[number]) "
        }
        showingScore = true
        counter += 1
        if counter == 8{
            isReached8 = true
        }else{
            isReached8 = false
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        scoreCounter = 0
        counter = 0
    }
}

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}

extension View {
    func setImage() -> some View {
        modifier(FlagImage())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
