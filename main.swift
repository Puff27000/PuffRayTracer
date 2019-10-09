//
//  main.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/4/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

let canvas = Canvas(width: 100, height: 100) //make canvas with width and height 100
let red = Color(red: 1, green: 0, blue: 0) //define red as color(1, 0, 0)
let black = Color(red: 0, green: 0, blue: 0)
let redSphere = Sphere() //make a new sphere
let world = World()
world.addObject(object: redSphere)
let light = PointLight(point: Tuple(x: 4, y: 4, z: -5, w: 1))
world.addLight(light: light)
let origin = Tuple.point( x: 0, y: 0, z: -5 )//origin = Point( x, y, -5 )
for row in (0..<canvas.height) { //for each row of pixels ( j )
    let yValue = 2 - Double(row) / 25.0  //y=2-j/25
    for column in (0..<canvas.width) { //for each pixel in the row ( i )
        let xValue = -2 + Double(column) / 25.0 //x=-2+i/25
        let pixelPosition = Tuple.point(x: xValue, y: yValue, z: 0)
        let direction = Tuple.normalize(tuple: (pixelPosition - origin))
        let ray = Ray(origin: origin, direction: direction)//ray = Ray(origin, direction = Vector (0, 0, 1) )
        let intersections = world.intersectionsWith( ray: ray )
        for intersection in intersections { //for (t in ts)
            //print("\(t_hit)")
            if intersection.t > 0 //if t > 0
            {
                let color = world.colorAtIntersection(intersection: intersection)
                canvas.changePixelAt(pixelX: column, pixelY: row, newColor: color)
                break
            }
        }
    }
}
//camera would eventually take over lines 19-38, line 11
print(canvas.canvasToPPM())




