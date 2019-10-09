//
//  PointLight.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/22/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class PointLight{
    
    var point : Tuple
    var intensity : Color
    
    init(point: Tuple, intensity: Color){
        
        self.point = point
        self.intensity = intensity
    }
    init(point: Tuple)
    {
        self.point = point
        self.intensity = Color(red: 1, green: 1, blue: 1) //intensity defaults to full
    }
}


