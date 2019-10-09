//
//  Matrix3x3.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 9/25/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

//matrix 4x4 needs a default init that makes the identity matrix
class Matrix3x3 : Equatable {
    
    var matrixData : [[Double]]
    
    func at( row: Int, column: Int ) -> Double
    {
        return self.matrixData[row][column]
    }
    
    static func == (matrixA: Matrix3x3, matrixB: Matrix3x3) -> Bool {
        for i in 0..<4
        {
            for j in 0..<4
            {
                if (abs(matrixA.matrixData[i][j] - matrixB.matrixData[i][j]) > 0)
                {
                    return false;
                }
            }
        }
        return true
    }
    
    func getSubmatrix3x3(elementI: Int, elementJ: Int) -> Matrix2x2 //taking in the coordinates of the element being looked at and returning a 2X2 matrix
    {
        var cofactorMatrixData: [[Double]] = []//start with a 2D array?
        let data3x3 = matrixData
        for i in 0..<3{
            if i == elementI { //don't store in the new matrix if the row index matches
                continue
            }
            var dataRow = [Double]()
            for j in 0..<3{
                if j == elementJ {
                    continue //don't store in the new matrix if the column index matches
                }
                else {
                    dataRow.append(data3x3[i][j]) //add to the cofactor data
                }
            }
            
          cofactorMatrixData.append(dataRow)  //turn the cofactor data into a 2x2 matrix and return it
        }
        return Matrix2x2(matrixData: cofactorMatrixData)
            //eliminate the column and row of the element we are looking at
        //create a 2x2 matrix out of all but the column/row of that ekement
    } // [i,j] is the 2X2 matrix excluding row i and column j
    
    func getMinor3x3(elementI: Int, elementJ: Int) -> Double //same params as submatrix, but returns a double (determinant of submatrix [i,j]
    {
        let submatrix = getSubmatrix3x3(elementI: elementI, elementJ: elementJ)
        return submatrix.determinant
    }
    //get determinant of the above submatrix
    
    func getCofactor(elementI: Int, elementJ: Int) -> Double
    {
        if elementI + elementJ % 2 == 1 //if the sum of i+j is odd, make it negative
        {
            return -getMinor3x3(elementI: elementI, elementJ: elementJ)
        }
        return getMinor3x3(elementI: elementI, elementJ: elementJ)
    }
    
    func getDeterminant3X3() -> Double
    {
        var determinant : Double = 0
        for i in 0..<3//loop through the 3X3 row 0
        {
            determinant += (matrixData[0][i] * getCofactor(elementI: 0, elementJ: i))
        }//multiply  element by the cofactor which is the determinant of the submatrix, adjusted pos/neg for position
        return determinant
    }
    
    
    init(matrixData: [[Double]])
    {
        self.matrixData = matrixData
    }
}
