import SwiftUI

struct Quote: Codable, Equatable {
    let quoteText: String
    let quoteAuthor: String
}

struct ContentView: View {
    @State private var quotes: [Quote] = []
    @State private var currentQuote: Quote?
    
    var body: some View {
        ScrollView {
                VStack {
                    Text(currentQuote?.quoteText ?? "")
                        .padding(3)
                        .font(.headline)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .animation(.easeInOut(duration: 0.5), value: currentQuote?.quoteText)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil) // Allow unlimited lines
                    HStack {
                        Spacer()
                        Text(currentQuote?.quoteAuthor.isEmpty == false ? currentQuote!.quoteAuthor : "Unknown")
                            .fontWeight(.thin)
                            .fontDesign(.rounded)
                            .font(.subheadline)
                            .animation(.easeInOut(duration: 0.5), value: currentQuote?.quoteAuthor)
                        Spacer()
                    }
                }
            }
        .onTapGesture {
            updateQuote()
        }
        .onAppear {
            loadQuotes()
            updateQuote()
        }
    }
    
    private func loadQuotes() {
        if let url = Bundle.main.url(forResource: "quotes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                quotes = try JSONDecoder().decode([Quote].self, from: data)
            } catch {
                print("Error loading quotes: \(error)")
            }
        }
    }
    
    private func updateQuote() {
        if let newQuote = quotes.randomElement(), newQuote != currentQuote {
            withAnimation {
                currentQuote = newQuote
            }
        }
    }
}

#Preview {
    ContentView()
}
