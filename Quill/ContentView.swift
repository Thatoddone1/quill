//
//  ContentView.swift
//  Quill
//
//  Created by Joshua Kellman on 7/24/24.
//

import SwiftUI



func fetchQuote(completionHandler: @escaping (String, String) -> Void) {
    let url = URL(string: "https://api.quotable.io/quotes/random")!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
            print("Error fetching quote: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
        }

        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let content = json["content"] as? String,
           let author = json["author"] as? String {
            completionHandler(content, author)
        }
    })
    task.resume()
}




struct ContentView: View {
    var body: some View {

        let quote = "TEST QUOTE"
        VStack{
            Spacer()
            Text(quote)
                .padding(10)
                .padding(.bottom, 30)
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
           Spacer()
        }
    }
}

#Preview {
    ContentView()
}
