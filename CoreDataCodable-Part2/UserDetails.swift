//
//  UserDetails.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//

import SwiftUI

struct UserDetails: View {
    let user : User
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 30){
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text(user.name ?? "unknown").font(.title.bold())
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(user.isActive ? .green : .gray)
                    .padding(.top, -25)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Age: \(user.age)")
                    Text("Email: \(user.email ?? "no email")")
                    Text("Company: \(user.company ?? "no job")")
                    Text("Date Registered: \(user.registered?.formatted() ?? "not date")")
                }
                .padding()
                .background(.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.cyan, lineWidth: 2))
                
                Text("More About \(user.name ?? "unknown")").padding(.bottom, -20).frame( alignment: .leading)
                
                Text(user.about ?? "no details")
                    .padding()
                    .background(.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay{RoundedRectangle(cornerRadius: 8).stroke(.blue, lineWidth: 2)}
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(user.tags?.components(separatedBy: ", ") ?? [], id: \.self){ tag in
                            Text(tag)
                        }
                    }
                }
                
//                ScrollView(.horizontal, showsIndicators: false){
//                    HStack{
//                        ForEach(user.friends as Array(Friend), id: \.name){friend in
//                            HStack{
//                                Image(systemName: "person.fill").resizable().scaledToFit()
//                                Text(friend.name)
//                            }
//                            .padding()
//                            .background(.gray.opacity(0.5))
//                            .clipShape(Capsule())
//                            //.overlay{Capsule().stroke(.cyan)}
//                            .overlay(content: {Capsule().stroke(lineWidth: 2)})
//                        }
//                    }
//                }
                
            }.padding(.horizontal)
        }
    }
}

//struct UserDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetails()
//    }
//}

