//
//  APIRequestViewModel.swift
//  GitHubExercice
//
//  Created by Zohra Achour on 25/10/2023.
//

import Foundation

//MARK: ON PRÉPARE A PART LA DONNÉE USER EN LIEN AVEC L'API

//on fait une classe parce que elle seule peuvent être appliquée sur toute l'application!
//avec le ObservableObject on indique qu'on va lire la même info partout
//
class UserAPIRequestViewModel {
    
    //on veut savoir les faits et gestes des @Published tel un stalker
//    @Published var allUser = [User]()
    
    //on prépare une fonction asynchrone pour ne pas surcharger le main thread
    //cette méthode va être utiliser sur un autre thread secondaire
    //et on veut pouvoir utiliser de la donnée de type User donc on attend un array de ça en retour
    func fetchedUsers() async -> [User] {
        var resultUser = [User]()
        
        //1er préparation -> est-ce-que mon url est le bon
        //si oui on continue notre fonction
        //sinon on s'arrête et on récup un erreur
        //dans le string de l'URL il faut: le url de votre table et son nom -> trouvez ça dans votre documentation API
        guard let url = URL(string: "https://api.airtable.com/v0/app5DwIdViTr1cf3t/User") else {
            print("URL unavailable")
            return resultUser
        }
        
        //si on arrive
        //on prépare la requête (ou notre demande auprès du serveur
        //"je suis telle personne et je veux récup ma donnée"
        var request = URLRequest(url: url) //-> on pause la question a cette URL
        request.httpMethod = "GET" // -> ma demande
        
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") // -> qui je suis
        
        
        //fait une suite d'actions, si elles ne sont pas possibles dans ce cas -> catch
        //le catch récup une erreur en fonction du résultat négatif de l'action
        do {
            
            //lorsqu'on se connecte sur un service, on créer une session
            //ici on lui demande d'ouvrir une session de connexion en fonction de ma requête
            //le TRY est pour voir si l'action ce fait sinon on renvoie une erreur détaillé
            //le AWAIT est là parce qu'on a une fonction en ASYNC, donc obligatoirement on a un await pour récup le résultat
            
            
            //si j'arrive à me connecter, je récup de la donnée et une réponse (sinon je pars dans le catch plus bas)
            let (data, response) = try await URLSession.shared.data(for: request)
            print(response) //<- si vous voulez voir à quoi ressemble une réponse serveur
            
            //ensuite on s'assure d'avoir une réponse positive sinon le reste du block s'arrête là
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Request wasn't successful")
                return resultUser
            }
            
            //si notre HTTPResponse est a 200 on récup et décode la data
            //le TRY me permet d'essayer de décoder sinon il renvoie une erreur
            //on veut décode de la donnée donc Type.self pour la partie decodable
            //et on veut appliquer ce décode sur la donnée en provenance du serveur, ici data
            let decodedRequest = try JSONDecoder().decode(UserRequest.self, from: data)
            print(decodedRequest) //<- résultat du décodage
            
            //comme on récup toute la requête on passe par une boucle forEach pour ajouter a notre array resultUser tous les utilisateurs trouvés lors du pull API
            decodedRequest.records.forEach { record in
                resultUser.append(record.fields)
            }
            
            //bonus pour trier par le nom des utilisateurs (pas obligatoire)
            //une closure -> fonction sans nom, qui s'applique sur des arrays ou d'autre types
            //on peut boucler avec et utiliser des let temporaire comme le .forEach a la 71
            //ou alors si on veut pas encore une fois déclarer un ou plusieurs let on peut utiliser le $0 ...
            //le $0 fonctionne comme le mot record a la ligne 71, il reprend chaque élément du tableau resultUser
            //le $1 permet de comparer
            //donc on compare 1 élément de tableau avec un autre et on voit lequel des deux vient se placer avant l'autre en fonction de l'ordre alphabétique (ici de A -> Z )
            resultUser.sort { $0.name < $1.name }
            
            return resultUser
            
        } catch let error { //<- si t'arrives pas à faire les actions dans le DO, renvoie une erreur
            print("ERROR: ", error)
        }
        
        return resultUser
    }
    
    
}
