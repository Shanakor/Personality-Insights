//
//  Insight+CoreDataProperties.swift
//  
//
//  Created by Niklas Rammerstorfer on 22.03.18.
//
//

import Foundation
import CoreData


extension Insight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insight> {
        return NSFetchRequest<Insight>(entityName: "Insight")
    }

    @NSManaged public var agreeablenessPercentile: Double
    @NSManaged public var conscientiousnessPercentile: Double
    @NSManaged public var date: NSDate?
    @NSManaged public var emotionalRangePercentile: Double
    @NSManaged public var introversionExtraversionPercentile: Double
    @NSManaged public var opennessPercentile: Double
    @NSManaged public var userName: String?

}
