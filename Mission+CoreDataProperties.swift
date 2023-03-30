//
//  Mission+CoreDataProperties.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
//

import Foundation
import CoreData


extension Mission {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mission> {
        return NSFetchRequest<Mission>(entityName: "Mission")
    }

    @NSManaged public var id: Int16
    @NSManaged public var launchDate: Date?
    @NSManaged public var desc: String?
    @NSManaged public var crew: NSSet?
    
    var wrappedLaunchDate : String{
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "Date not available"
    }
    
    var wrappedDesc : String{
        desc ?? "No further infomation"
    }
    
    var wrappedCrew : [Crew]{
        var theCrew = crew as? Set<Crew> ?? []
        return theCrew.sorted{
            $0.wrappedName < $1.wrappedName
        }
        
    }

}

// MARK: Generated accessors for crew
extension Mission {

    @objc(addCrewObject:)
    @NSManaged public func addToCrew(_ value: Crew)

    @objc(removeCrewObject:)
    @NSManaged public func removeFromCrew(_ value: Crew)

    @objc(addCrew:)
    @NSManaged public func addToCrew(_ values: NSSet)

    @objc(removeCrew:)
    @NSManaged public func removeFromCrew(_ values: NSSet)

}

extension Mission : Identifiable {

}
