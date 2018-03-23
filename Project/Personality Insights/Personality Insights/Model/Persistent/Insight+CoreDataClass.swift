//
//  Insight+CoreDataClass.swift
//  
//
//  Created by Niklas Rammerstorfer on 22.03.18.
//
//

import Foundation
import CoreData

public class Insight: NSManagedObject {

    static let entityName = "Insight"

    convenience init(from transInsight: TransientInsight, context: NSManagedObjectContext){
        let entityName = "Insight"

        if let ent = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            self.init(entity: ent, insertInto: context)

            self.emotionalRangePercentile = transInsight.emotionalRangePercentile
            self.conscientiousnessPercentile = transInsight.conscientiousnessPercentile
            self.introversionExtraversionPercentile = transInsight.introversionExtraversionPercentile
            self.agreeablenessPercentile = transInsight.agreeablenessPercentile
            self.opennessPercentile = transInsight.opennessPercentile
            self.userName = transInsight.userName
            self.date = transInsight.date as NSDate
        } else {
            fatalError("Unable to find Entity name '\(entityName)'!")
        }
    }
}
