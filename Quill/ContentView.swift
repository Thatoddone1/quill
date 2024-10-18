//
//  ContentView.swift
//  Quill
//
//  Created by Joshua Kellman on 7/24/24.
//

import SwiftUI



let quote = [["To be or not to be, that is the question.", "William Shakespear"], ["The only thing we have to fear is fear itself.", "Franklin D. Rosevelt"]]

struct ContentView: View {
    @State private var currentQuote: String = ""
    @State private var currentAuthor: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(currentQuote)
                    .padding(10)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .animation(.easeInOut(duration: 0.5), value: currentQuote)
                HStack {
                    Text(currentAuthor)
                        .padding(.leading, 20)
                        .fontWeight(.light)
                        .fontDesign(.rounded)
                        .animation(.easeInOut(duration: 0.5), value: currentAuthor)
                    Spacer()
                }
            }
            Spacer()
        }
        .onTapGesture {
            updateQuote()
        }
        .onAppear {
            updateQuote()
        }
    }

    
    private func updateQuote() {
        if let newQuote = newQuote(quote: quote) {
            if newQuote[0] != currentQuote{
                withAnimation {
                    currentQuote = newQuote[0]
                    currentAuthor = newQuote[1]
                }
            }
        }
    }
}



func newQuote(quote: [[String]]) -> [String]? {
    return quote.randomElement()
}


#Preview {
    ContentView()
}
