//
// Created by Niklas Rammerstorfer on 05.01.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStackFacade {

    // MARK: Properties

    static let shared = CoreDataStackFacade()

    private let coreDataStack = (UIApplication.shared.delegate as! AppDelegate).coreDataStack

    // MARK: Initialization

    private init() {}

    // MARK: Convenience Methods

    func saveMainContext(){
        do {
            try coreDataStack.saveMainContext()
        }
        catch{
            print("Error while persisting mainContext: \n \(error)")
        }
    }

    func saveBackgroundContext(){
        do {
            try coreDataStack.saveBackgroundContext()
        }
        catch{
            print("Error while persisting backgroundContext: \n \(error)")
        }
    }

    typealias Batch = (_ workerContext: NSManagedObjectContext) -> ()

    func performBackgroundBatchOperation(_ batch: @escaping Batch) {
        coreDataStack.performBackgroundBatchOperation{
            workerContext in self.coreDataStack.performBackgroundBatchOperation(batch)
        }
    }
}

// MARK: TravelLocation Convenience Methods

extension CoreDataStackFacade {

    func fetchAllInsightsAsync() -> [Insight]{
        let fr = NSFetchRequest<Insight>(entityName: Insight.entityName)
        var insights = [Insight]()

        do {
            let fetchedInsights = try coreDataStack.backgroundContext.fetch(fr)

            for insight in fetchedInsights {
                insights.append(insight)
            }
        } catch {
            print("Unable to fetch Insights!")
        }

        return insights
    }
}
