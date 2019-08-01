//
//  Firestore.swift
//  intern-borathon-2019
//
//  Created by Aubhro Sengupta on 7/31/19.
//  Copyright © 2019 Team Rocket. All rights reserved.
//

import Foundation
import FirebaseFirestore

let db = Firestore.firestore()

func getCollection(atGarage garage: String, completion: @escaping ([DataPoint]) -> Void) {
    db.collection(garage).order(by: "index").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
            completion([DataPoint]())
        } else {
            var points: [DataPoint] = []
            for document in querySnapshot!.documents {
                if document.documentID != "numEntries" {
                    let data = document.data()
                    let stamp = data["time"] as! Timestamp
                    let point = DataPoint(indexOf: data["index"] as! Int,
                                          numberOfCars: data["cars"] as? Int ?? 0,
                                          at: stamp.dateValue())
                    points.append(point)
                }
            }
            completion(points)
        }
    }
}
