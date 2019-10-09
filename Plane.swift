//
//  Plane.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 10/9/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Plane : Object {

    var transform: Matrix4x4
    var material: Material
    
    init()
    {
        self.material = Material()
        self.transform = Matrix4x4()
    }
    
    func scale(x: Double, y: Double, z: Double)
    {
        let scalingMatrix = Matrix4x4()
        scalingMatrix.matrixData[0][0] = x
        scalingMatrix.matrixData[1][1] = y
        scalingMatrix.matrixData[2][2] = z
        
        self.transform = self.transform * scalingMatrix // (remember not commutative!)
    }
    
    func translate(x: Double, y: Double, z: Double)
    {
        let transformMatrix = Matrix4x4()
        transformMatrix.matrixData[0][3] = x
        transformMatrix.matrixData[1][3] = y
        transformMatrix.matrixData[2][3] = z
        
        self.transform = self.transform * transformMatrix // (remember not commutative!)
    }
    
    func normalAt(point: Tuple) -> Tuple
    {
        let objectSpacePoint = self.transform.invert() * point //getting pt in obj space
        let vector = Tuple.vector(x: objectSpacePoint.x, y: objectSpacePoint.y, z: objectSpacePoint.z) //getting the vec to that point in obj space
        let vecInWorldSpace = self.transform.invert().transpose() * vector
        return Tuple.normalize(tuple: vecInWorldSpace)
    }
    
    func intersectionsWith(ray: Ray) -> [Intersection]
    {
        let rayInSphereCoords = ray.transform(matrix: self.transform.invert())
        let quadraticA = Tuple.dot(tupleA: rayInSphereCoords.direction, tupleB: rayInSphereCoords.direction)
        let vecToRayOrigin = rayInSphereCoords.origin - Tuple(x: 0, y: 0, z: 0, w: 1)
        let quadraticB = Tuple.dot(tupleA: rayInSphereCoords.direction, tupleB: vecToRayOrigin) * 2
        let quadraticC = Tuple.dot(tupleA: vecToRayOrigin, tupleB: vecToRayOrigin) - 1
        let discriminant = ( quadraticB * quadraticB ) - 4 * quadraticA * quadraticC
        
        if discriminant < 0
        {
            return []
        }
        else if discriminant == 0
        {
            let timeT =  -quadraticB / ( 2 * quadraticA )
            let intersection = Intersection(t: timeT, ray: ray, object: self)
            return [ intersection, intersection ]
        }
        else
        {
            let timeT1 = ( -quadraticB - sqrt(discriminant)) / ( 2 * quadraticA )
            let intersection1 = Intersection(t: timeT1, ray: ray, object: self)
            let timeT2 = ( -quadraticB + sqrt(discriminant)) / ( 2 * quadraticA )
            let intersection2 = Intersection(t: timeT2, ray: ray, object: self)
            return [ intersection1, intersection2]
        }
    }
    
}
