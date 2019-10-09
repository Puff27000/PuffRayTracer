//
//  Canvas.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/17/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Canvas {
    var width : Int
    var height : Int
    var pixelColors : [[Color]]
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        self.pixelColors = Array( repeating: Array( repeating: Color(red: 0, green: 0, blue: 0), count: width ), count: height ) //initializing 2d array
    }
    
    func colorToInt( color: Color ) -> ( Int, Int, Int ) //because my Tuple class holds doubles and we want to do integer math
    {
        var redX255 = round( color.red * 255 )
        if( redX255 < 0)
        {
            redX255 = 0
        }
        else if( redX255 > 255 )
        {
            redX255 = 255
        }
        var greenX255 = round( color.green * 255 )
        if( greenX255 < 0)
        {
            greenX255 = 0
        }
        else if( greenX255 > 255 )
        {
            greenX255 = 255
        }
        var blueX255 = round( color.blue * 255 )
        if( blueX255 < 0)
        {
            blueX255 = 0
        }
        else if( blueX255 > 255 )
        {
            blueX255 = 255
        }
        
        return ( Int(redX255), Int(greenX255), Int(blueX255) )
        
    }
    
    func changePixelAt( pixelX : Int , pixelY : Int, newColor : Color )
    {
        self.pixelColors[pixelY][pixelX] = newColor//go through the array and find the pixel
    }
    
    func canvasToPPM() -> String
    {
        var PPMdata = writePPMHeader()
        for row in pixelColors{
            for pixelColor in row{
                let ( red, green, blue ) = colorToInt( color: pixelColor )
                PPMdata += "\(red) \(green) \(blue) "
            }
            PPMdata += "\n"
        }
        return PPMdata
    }
    
    func writePPMHeader() -> String
    {
        let width = self.width
        let height = self.height
        let PPMHeader = "P3\n \(width) \(height) \n 255\n"
        return PPMHeader
    }
    
}


