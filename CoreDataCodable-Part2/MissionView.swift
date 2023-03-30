//
//  MissionView.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import SwiftUI
import CoreData

struct MissionView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var CDMissions : FetchedResults<Mission>
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(CDMissions, id: \.self){mission in
                        NavigationLink{
                            MissionDescView(mission: mission)
                        } label: {
                            Text("Appollo \(mission.id)")
                        }
                    }
                }
            }.onAppear{
                if CDMissions.isEmpty{
                    fetchMissions()
                }
            }
            .navigationTitle("test")
        }
    }
    
    func fetchMissions() {
        guard let url = Bundle.main.url(forResource: "missions.json", withExtension: nil) else { return }
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.moc
            
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            try decoder.decode([Mission].self, from: data)
            
        } catch  {
            print(error.localizedDescription)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
