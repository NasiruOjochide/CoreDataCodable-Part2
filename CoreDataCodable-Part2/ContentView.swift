//
//  ContentView.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var todoItem : FetchedResults<TodoItem>
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(todoItem, id: \.self){item in
                        Text(item.label ?? "yeyeye")
                    }
                }
                
                Button("load data"){
                    Task{
                        if todoItem.isEmpty{
                            try? await fetchdata()
                        }
                    }
                }
            }.navigationTitle("testing")
        }
    }
    
    func fetchdata() async{
        let fetchTask = Task{() -> [TodoItem] in
            guard let url = Bundle.main.url(forResource: "Untitled.txt", withExtension: nil)else{return []}
            guard let data = try? Data(contentsOf: url) else{return []}
            
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.moc
                
                let decodedData = try decoder.decode([TodoItem].self, from: data)
                
                try moc.save()
            
            return decodedData
        }
       
        let result = await fetchTask.result
        
        do {
            _ = try result.get()
            print("success")
        } catch  {
            print(error.localizedDescription)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
