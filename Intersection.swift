//
//  Intersection.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 10/8/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

struct HitRecord {
    var hitPoint : Tuple //point-- the point in world space in which the intersection of ray with object occurs
    var normalVector : Tuple //unit vector
    var eye : Tuple //unit vector
    var isInside : Bool
}

class Intersection{
    
    var t : Double
    var ray : Ray
    var object : Object 
    
    init(t : Double, ray : Ray, object : Object) {
        
        self.t = t
        self.ray = ray
        self.object = object
    }
    
    
    func generateHitRecord() -> HitRecord //optional-- use t and object and ray from Intersection to calculate the hitRecord
    {
        let hitPoint = self.ray.PointAtT(t: self.t) // origin plus direction times t = hitpoint (pointAtT in Ray)
        var normalVec = self.object.normalAt(point: hitPoint)
        let eye = Tuple.normalize(tuple: (self.ray.origin - hitPoint))//want to save the vector from hitPoint of object to eye
        var isInside = false //if the dot product normalVec and eye is less than zero, we are inside.
        if Tuple.dot(tupleA: normalVec, tupleB: eye) < 0
        {
            isInside = true
            normalVec = -normalVec //if isInside == true, reverse the direction of the normalVec
        }
        let hitRecord = HitRecord( hitPoint: hitPoint, normalVector: normalVec, eye: eye, isInside: isInside)
        return hitRecord
    }
    
}
