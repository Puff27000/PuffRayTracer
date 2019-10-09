//
//  Object.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 10/8/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

protocol Object {
    
    var transform : Matrix4x4 { get set } //should these be both get and set?
    var material : Material { get set }
    
    func scale(  x: Double, y: Double, z: Double ) //copied from sphere- is this right?set
    
    func translate( x: Double, y: Double, z: Double ) //copied from sphere- is this right?
    
    func intersectionsWith( ray: Ray ) -> [Intersection]
    
     func normalAt(point: Tuple) -> Tuple
}
