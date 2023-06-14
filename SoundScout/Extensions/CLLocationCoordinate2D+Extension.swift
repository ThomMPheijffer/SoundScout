//
//  CLLocationCoordinate2D+Extension.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 14/06/2023.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}
