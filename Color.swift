//
//  Color.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/11/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Color: Tuple
{
    init( red: Double, green: Double, blue: Double )
    {
        super.init(x: red, y: green, z: blue, w: 0)
    }
    init()
    {
        super.init(x: 0, y: 0, z: 0, w: 0)
    }
    
    var red : Double {
        get {
            return x
        }
        set {
           x = newValue
        }
    }
    
    var green: Double {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    var blue: Double {
        get {
            return z
        }
        set {
            z = newValue
        }
        
    }
    
    //need color * color. element-wise multiplication, use only for colors
    static func * (colorA: Color, colorB: Color) -> Color
    {
        let newRed = colorA.x * colorB.x
        let newGreen = colorA.y * colorB.y
        let newBlue = colorA.z * colorB.z
        return Color(red: newRed, green: newGreen, blue: newBlue)
    }
    
    static func * (tuple: Color, scalar: Double) -> Color //overloading * with scalar mult
    {
        let tupleTimesScalar = Color(red: tuple.x * scalar, green: tuple.y * scalar, blue: tuple.z * scalar)
        return tupleTimesScalar
    }
    
    static func + (colorA: Color, colorB: Color) -> Color
    {
        let newRed = colorA.x + colorB.x
        let newGreen = colorA.y + colorB.y
        let newBlue = colorA.z + colorB.z
        return Color(red: newRed, green: newGreen, blue: newBlue)
    }
    
    
}
