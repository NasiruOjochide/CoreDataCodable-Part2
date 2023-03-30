//
//  MissionDescView.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import SwiftUI

struct MissionDescView: View {
    var mission : Mission
    var body: some View {
        VStack{
            Text("Appollo \(mission.id)")
            
            Text(mission.wrappedLaunchDate)
            
            Text(mission.wrappedDesc)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10){
                    ForEach(mission.wrappedCrew, id: \.name){crewMember in
                        VStack(alignment: .leading, spacing: 5){
                            Text(crewMember.wrappedName)
                            Text(crewMember.wrappedRole)
                        }
                    }
                }
            }
        }.padding()
    }
}

//struct MissionDescView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionDescView()
//    }
//}
