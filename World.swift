//
//  World.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 10/8/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class World {
    
    var objects = [Object]()
    var lights = [PointLight]()
    
    func addObject( object : Object )
    {
        self.objects.append(object)
    }
    
    func addLight( light : PointLight )
    {
        self.lights.append(light)
    }
    
    class func defaultWorld() -> World
    {
        let defaultWorld = World()
        defaultWorld.addLight( light: PointLight(point: Tuple.point(x: -10, y: 10, z: -10), intensity: Color(red: 1, green: 1, blue: 1 )))
        let sphere1 = Sphere()
        sphere1.material = Material(ambient: 0, specular: 0.2, diffuse: 0.7, color: Color(red: 0.8, green: 0.1, blue: 0.6))
        let sphere2 = Sphere()
        sphere2.scale(x: 0.5, y: 0.5, z: 0.5)
        
        defaultWorld.addObject(object: sphere1)
        defaultWorld.addObject(object: sphere2)
        
        return defaultWorld
    }
    
    func intersectionsWith( ray : Ray ) -> [Intersection] //returned list must be sorted by t-values. What is this function for?
    {
        //meta-version of the sphere version. It takes a ray and goes through each of the objects in the scene and asks each object "do I intersect with you?" and takes the array of intersections from each object, concatenates into one big array, and sorts by t value
        var worldIntersections = [Intersection]()
        
        for object in self.objects
        {
            let intersectionsWithObject = object.intersectionsWith(ray: ray)
            if intersectionsWithObject.count > 0
            {
                for intersection in intersectionsWithObject
                {
                worldIntersections.append(intersection)
                }
            }
        }
        
        let worldIntersectionsSortedByT = worldIntersections.sorted(by: { $0.t < $1.t }) //thanks stack overflow-- this gives ascending sort order
        return worldIntersectionsSortedByT
    }
    
    func colorAtIntersection( intersection : Intersection ) -> Color //what is this func for?
    {
        let hitRecord = intersection.generateHitRecord()
        return intersection.object.material.colorAtPoint(hitRecord: hitRecord, lights: self.lights)
    }
    
}
