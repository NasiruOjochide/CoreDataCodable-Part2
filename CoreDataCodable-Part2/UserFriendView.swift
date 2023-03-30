//
//  UserFriendView.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import SwiftUI

struct UserFriendView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cachedUsers : FetchedResults<User>
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(cachedUsers, id: \.id){user in
                        NavigationLink{
                            UserDetails(user: user)
                        } label: {
                            HStack(alignment: .bottom){
                                Text(user.name ?? "unknown")
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 0){
                                    user.isActive ? Text("Online") : Text("Offline")
                                    Image(systemName: "circle.fill").resizable().scaledToFit().frame(width: 10, height: 10).foregroundColor(user.isActive ? .green : .gray)
                                }
                            }
                        }
                    
                    }}.task{
                        if cachedUsers.isEmpty{
                            await fetchUserData()
                        }
                                        
                    }
                
                
            }.navigationTitle("Users")
        }
    }
    
    func fetchUserData() async{
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do{
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.moc
            decoder.dateDecodingStrategy = .iso8601
            
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            _ = try decoder.decode([User].self, from: data)
            
//            try moc.save()
            //users = decodedData
        }
        catch{
            print(error.localizedDescription)
        }
    }
}

struct UserFriendView_Previews: PreviewProvider {
    static var previews: some View {
        UserFriendView()
    }
}
