//
//  File.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/11/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Ray {
    
    var origin: Tuple //should be point
    var direction: Tuple //should be normalized unit vector
    
    init(origin: Tuple, direction: Tuple){ //could check if mag squared is 1, if not, normalize the direction to make sure it's a unit vector
        self.origin = origin
        self.direction = direction
    }
    

        
    func PointAtT(t: Double) -> Tuple
    {
    let pointAtT = direction * t + origin //direction * t + origin
    return pointAtT
    }
    
    func transform( matrix: Matrix4x4 ) -> Ray //return a ray that is matrix * origin, matrix * direction
    {
        return Ray(origin: matrix * self.origin, direction: matrix * self.direction)
    }
}


