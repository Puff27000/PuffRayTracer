//
//  Matrix2x2.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/25/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Matrix2x2 : Equatable {
    
    var matrixData : [[Double]]
    var determinant : Double
    
    init(matrixData: [[Double]])
    {
        self.matrixData = matrixData
        
        let elementA = matrixData[0][0]
        let elementB = matrixData[0][1]
        let elementC = matrixData[1][0]
        let elementD = matrixData[1][1]
        
        self.determinant = (elementA * elementD) - (elementB * elementC)
    }
    
    static func == (matrixA: Matrix2x2, matrixB: Matrix2x2) -> Bool {
        for i in 0..<2
        {
            for j in 0..<2
            {
                if (abs(matrixA.matrixData[i][j] - matrixB.matrixData[i][j]) > 0)
                {
                    return false;
                }
            }
        }
        return true
    }
    
    func at( row: Int, column: Int ) -> Double
    {
        return self.matrixData[row][column]
    }
}
