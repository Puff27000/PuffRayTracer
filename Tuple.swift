//
//  Tuple.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/4/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Tuple: Equatable{
    static func == (lhs: Tuple, rhs: Tuple) -> Bool {
        if (abs(lhs.x - rhs.x) < 0.00001 && abs(lhs.y - rhs.y) < 0.00001 && abs(lhs.z - rhs.z) < 0.00001) {
        return true
        }
                else{
        return false
        }
    }
    
    
    var x: Double
    var y: Double
    var z: Double
    var w: Double
    
    init(x: Double, y: Double, z: Double, w: Double){ //here is where we put the parameters we want the class to take in
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    func isPoint() -> Bool
     {
        if self.w == 1.0
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func isVector() -> Bool
    {
        if self.w == 0.0
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    class func point( x: Double, y: Double, z: Double ) -> Tuple
    {
        return Tuple(x: x, y: y, z: z, w: 1)
    }
    
    class func vector( x: Double, y: Double, z: Double ) -> Tuple
    {
        return Tuple(x: x, y: y, z: z, w: 0)
    }
    
    static func + ( tupleA: Tuple, tupleB: Tuple ) -> Tuple //operator overload!!
    {
        let sumX = tupleA.x + tupleB.x
        let sumY = tupleA.y + tupleB.y
        let sumZ = tupleA.z + tupleB.z
        let sumW = tupleA.w + tupleB.w
        return Tuple( x: sumX, y:sumY, z:sumZ, w:sumW )
    }
    
    static func - ( tupleA: Tuple, tupleB: Tuple ) -> Tuple //operator overload!!
    {
        let diffX = tupleA.x - tupleB.x
        let diffY = tupleA.y - tupleB.y
        let diffZ = tupleA.z - tupleB.z
        let diffW = tupleA.w - tupleB.w
        return Tuple( x: diffX, y: diffY, z: diffZ, w: diffW )
    }
    
    static prefix func - (tuple: Tuple) -> Tuple
    {
        return Tuple(x: -tuple.x, y: -tuple.y, z: -tuple.z, w: -tuple.w) //w changes too for generic tuples
    }
    
    static func * (tuple: Tuple, scalar: Double) -> Tuple //overloading * with scalar mult
    {
        let tupleTimesScalar = Tuple(x: tuple.x * scalar, y: tuple.y * scalar, z: tuple.z * scalar, w: tuple.w * scalar)
        return tupleTimesScalar
    }
    
    static func / (tuple: Tuple, scalar: Double) -> Tuple //overloading / with scalar division
    {
        let tupleDivScalar = Tuple(x: tuple.x / scalar, y: tuple.y / scalar, z: tuple.z / scalar, w: tuple.w / scalar)
        return tupleDivScalar
    }
    
    static func magnitude (tuple: Tuple) -> Double //square each entry, add, then square root
    {
        let squaredVector = vector( x: tuple.x * tuple.x, y: tuple.y * tuple.y, z: tuple.z * tuple.z )
        let sumOfSquares = (squaredVector.x + squaredVector.y + squaredVector.z)
        return sqrt(sumOfSquares)
    }
    
    static func normalize(tuple: Tuple) -> Tuple //divide each entry by the magnitude
    {
        return tuple/magnitude(tuple: tuple)
    }
    
    static func dot(tupleA: Tuple, tupleB: Tuple) -> Double //ax times bx plus ay times by
    {
        let newX = tupleA.x * tupleB.x
        let newY = tupleA.y  * tupleB.y
        let newZ = tupleA.z * tupleB.z
        return newX + newY + newZ
    }
    
    static func cross(tupleA: Tuple, tupleB: Tuple) -> Tuple //
    {
        let crossX = tupleA.y * tupleB.z - tupleA.z * tupleB.y
        let crossY = tupleA.z * tupleB.x - tupleA.x * tupleB.z
        let crossZ = tupleA.x * tupleB.y - tupleA.y * tupleB.x
        return Tuple(x: crossX, y: crossY, z: crossZ, w: 0) //w stays zero since we are returning a vector
    }
    
    func reflectedOver( vecToReflectOver : Tuple ) -> Tuple
    {
        let projectedVec = vecToReflectOver * (Tuple.dot(tupleA: vecToReflectOver, tupleB: self))//want to project self onto this vectoreflectover
        let reflectedVec = projectedVec * 2 - self //making the parallelogram
        return reflectedVec
    }
}
