//
//  Material.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/22/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Material{
    
    var ambient : Double
    var specular : Double
    var diffuse : Double
    var color : Color
    var shininess : Double
    
    //should have ambient, specular, diffuse floats and take a color (default to white)
    init( ambient: Double, specular: Double, diffuse: Double, color: Color )
    {
        self.ambient = ambient
        self.specular = specular
        self.diffuse = diffuse
        self.color = color
        self.shininess = 50.0
    }
    init()
    {
        self.ambient = 0.0
        self.specular = 1.0
        self.diffuse = 1.0
        self.color = Color(red: 1, green: 1, blue: 1)
        self.shininess = 50.0
    }
    
    func colorAtPoint( hitRecord : HitRecord, lights : [PointLight] ) -> Color
    {
        var colorToReturn = Color()
        for light in lights
        {
            let vecToLight = Tuple.normalize(tuple: light.point - hitRecord.hitPoint)
            let gradient = max(0, Tuple.dot(tupleA: hitRecord.normalVector, tupleB: vecToLight))
            let diffuseColor = light.intensity * self.color * gradient * self.diffuse
            colorToReturn = colorToReturn + diffuseColor
            
            let ambientColor = light.intensity * self.color * self.ambient
            colorToReturn = colorToReturn + ambientColor
            
            let reflectedVecToLight = vecToLight.reflectedOver(vecToReflectOver: hitRecord.normalVector)//get vector to light reflected over normalVec
            
            var specularity = max(0, Tuple.dot(tupleA: reflectedVecToLight, tupleB: hitRecord.eye))
            
            specularity = pow(specularity, self.shininess) //raised to the power of SHININESS!
            let specularColor = light.intensity * specularity * self.specular
            colorToReturn = colorToReturn + specularColor
        }
        return colorToReturn 
        
        //ColorAtPoint should be the color of the object * the color of the light at its brightest. This is the base color.
        //At it's darkest, should return black.
        //it should be brightest when the normalized vec from point to light is the same as normalVec
        //vectors that don't have to pass through the object to get to the light will be lit
        //vector to the light has to be tangent to surface of sphere
        //vectors at darkest point are perpendicular to the normalVec
        //use cosine of the angle between the distance to get the gradient (dot product the two vectors)
        //dot product needs to be clamped at zero (negative values read as zero) --use max(0, dot) * color of light * color of object
        //most likely to fail if I forget to normalize any of the vectors (check vec from point to light)
        //future work: return ambient and specular as well
    }
}
