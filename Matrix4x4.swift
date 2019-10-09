//
//  Matrix4x4.swift
//  Puff_RayTracer
//
//  Created by Sophia Marx on 10/1/19.
//  Copyright © 2019 puff.mx. All rights reserved.
//

import Foundation

class Matrix4x4 : Equatable {
    
    var matrixData : [[Double]]
    //need to find the submatrix that is the top left corner 3x3 and get the determinant of that
    init( matrixData: [[Double]] )
    {
        
        self.matrixData = matrixData
    }
    
    init() //default constructor sets up the 4x4 identity matrix
    {
        self.matrixData = [[1, 0, 0, 0],[0, 1, 0, 0],[0, 0, 1, 0],[0, 0, 0, 1]]
    }
    
    static func == (matrixA: Matrix4x4, matrixB: Matrix4x4) -> Bool {
        for i in 0..<4
        {
            for j in 0..<4
            {
                if (abs(matrixA.matrixData[i][j] - matrixB.matrixData[i][j]) > 0.001)
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
        
        func getSubmatrix4x4(elementI: Int, elementJ: Int) -> Matrix3x3 //taking in the coordinates of the element being looked at and returning a 3X3 matrix
        {
            var cofactorMatrixData: [[Double]] = []//start with a 2D array
            let data4x4 = matrixData
            for i in 0..<4{
                if i == elementI { //don't store in the new matrix if the row index matches
                    continue
                }
                var dataRow = [Double]()
                for j in 0..<4{
                    if j == elementJ {
                        continue //don't store in the new matrix if the column index matches
                    }
                    else {
                        dataRow.append(data4x4[i][j]) //add to the cofactor data
                    }
                }
                
                cofactorMatrixData.append(dataRow)  //turn the cofactor data into a 3x3 matrix and return it
            }
            return Matrix3x3(matrixData: cofactorMatrixData)
            
        } // [i,j] is the 2X2 matrix excluding row i and column j
        
        func getMinor4x4(elementI: Int, elementJ: Int) -> Double //same params as submatrix, but returns a double (determinant of submatrix [i,j]
        {
            let submatrix = getSubmatrix4x4(elementI: elementI, elementJ: elementJ)
            return submatrix.getDeterminant3X3()
        }
        //get determinant of the above submatrix
        
        func getCofactor(elementI: Int, elementJ: Int) -> Double
        {
            if (elementI + elementJ) % 2 == 1 //if the sum of i+j is odd, make it negative
            {
                return -getMinor4x4(elementI: elementI, elementJ: elementJ)
            }
            return getMinor4x4(elementI: elementI, elementJ: elementJ)
        }
        
        
        func getDeterminant() -> Double
        {
            let upperLeftDeterminant = self.getCofactor(elementI: 3, elementJ: 3)
            return upperLeftDeterminant
        }
    
        func transpose() -> Matrix4x4
        {
            var matrixData = [[Double]]()
            //the transpose of matrix
            for j in 0..<4 //reverse j and i like this to traverse column-wise through matrix
            {
                var matrixRow : [Double] = []
                for i in 0..<4
                {
                    matrixRow.append(self.matrixData[i][j])
                }
                matrixData.append(matrixRow) //this is the transpose!
            }
            
            let transpose = Matrix4x4(matrixData: matrixData)
            return transpose
        }
    
        func invert() -> Matrix4x4
        {
            var inverseData = [[Double]]()
            //the transpose of a matrix of cofactors
            for j in 0..<4 //reverse j and i like this to traverse column-wise through matrix
            {
                var matrixRow : [Double] = []
                for i in 0..<4
                {
                    matrixRow.append(getCofactor(elementI: i, elementJ: j))
                }
                
                inverseData.append(matrixRow) //this is the transpose!
            }
            
            let inverseDataMatrix = Matrix4x4(matrixData: inverseData)
            let inverse = inverseDataMatrix * (1/getDeterminant())
            return inverse
        }

        func invertible() -> Bool
        {
            if self.getDeterminant() != 0
            {
                return true
            }
            return false
        }
        
        
        static func * (matrix: Matrix4x4, scalar: Double) -> Matrix4x4 //overloading * with scalar mult
        {
            let multipliedMatrix = matrix.matrixData.map { $0.map { $0 * scalar } } //element-wise multiplication using map! Thanks Justin!
            return Matrix4x4( matrixData: multipliedMatrix )
        }
        
        static func * (matrix: Matrix4x4, tuple: Tuple) -> Tuple //also define multiplication with a Tuple
        {
            var productData = [Double]()
            for i in 0..<4
            {
                let rowEl0 = matrix.matrixData[i][0] * tuple.x
                let rowEl1 = matrix.matrixData[i][1] * tuple.y
                let rowEl2 = matrix.matrixData[i][2] * tuple.z
                let rowEl3 = matrix.matrixData[i][3] * tuple.w
                let rowSum = rowEl0 + rowEl1 + rowEl2 + rowEl3
                productData.append(rowSum)
            }
            
            let productTuple = Tuple(x: productData[0], y: productData[1], z: productData[2], w: productData[3])
            return productTuple
        }
        
        // and multiplication between 2 matrices
        static func * (matrixA: Matrix4x4, matrixB: Matrix4x4) -> Matrix4x4
        {
            var productMatrixData = Array(repeating: Array( repeating: 0.0, count: 4), count: 4) //syntax help from Stack Overflow
            
            for i in 0..<4
            {
                for j in 0..<4
                {
                    productMatrixData[i][j] = (matrixA.matrixData[i][0] * matrixB.matrixData[0][j]
                        + matrixA.matrixData[i][1] * matrixB.matrixData[1][j]
                        + matrixA.matrixData[i][2] * matrixB.matrixData[2][j]
                        + matrixA.matrixData[i][3] * matrixB.matrixData[3][j])
                }
            }
            return Matrix4x4(matrixData: productMatrixData)
        }
}

