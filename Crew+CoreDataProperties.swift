//
//  Crew+CoreDataProperties.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
//

import Foundation
import CoreData


extension Crew {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crew> {
        return NSFetchRequest<Crew>(entityName: "Crew")
    }

    @NSManaged public var name: String?
    @NSManaged public var role: String?
    @NSManaged public var mission: Mission?
    
    var wrappedName: String{
        name ?? "unknown fucker"
    }
    
    var wrappedRole: String{
        role ?? "Jobless"
    }

}

extension Crew : Identifiable {

}
