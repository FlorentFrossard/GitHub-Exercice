//
//  DrinkAPIRequestViewModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 27/10/2023.
//

import Foundation

class DrinkAPIRequestViewModel: ObservableObject {
    
    @Published var allDrink = [Drink]()
    
    func formatPrice(index: Int) -> String {
       String(format: "%.2f", self.allDrink[index].price)
    }
    
    func fetchedDrinks() async -> [Drink] {
        var fetchedDrinks = [Drink]()
        
        guard let baseURL = URL(string: "https://api.airtable.com/v0/app5DwIdViTr1cf3t/Drink") else {
            print("wrong url")
            return fetchedDrinks
        }
        
        var drinkRequest = URLRequest(url: baseURL)
        drinkRequest.httpMethod = "GET"
        drinkRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            let (serverData, serverResponse) = try await URLSession.shared.data(for: drinkRequest)
            guard let httpResp = serverResponse as? HTTPURLResponse, httpResp.statusCode == 200 else {
                print("bad server response")
                return fetchedDrinks
            }
            
            let parsedRecord = try JSONDecoder().decode(DrinkRequest.self, from: serverData)
            
            parsedRecord.records.forEach { drink in
                fetchedDrinks.append(drink.fields)
            }
            
            return fetchedDrinks
            
            
        } catch let error {
            print("ERROR:", error)
        }
        
        return fetchedDrinks
    }
    
    
}
