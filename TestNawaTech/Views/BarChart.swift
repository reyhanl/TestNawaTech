//
//  BarChart.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

class BarChartView: UIView {
    
    var dataPoints: [String] = []
    var values: [CGFloat] = []
    
    override func draw(_ rect: CGRect) {
        guard !dataPoints.isEmpty, values.count == dataPoints.count else {
            return
        }
        
        let maxValue = values.max() ?? 0
        
        let barWidth = rect.width / CGFloat(dataPoints.count)
        
        for (index, value) in values.enumerated() {
            let barHeight = rect.height * (value / maxValue)
            let barOriginX = CGFloat(index) * barWidth
            let barOriginY = rect.height - barHeight
            
            let barRect = CGRect(x: barOriginX, y: barOriginY, width: barWidth, height: barHeight)
            
            let barPath = UIBezierPath(rect: barRect)
            
            let randomColor = UIColor(red: .random(in: 0...1),
                                      green: .random(in: 0...1),
                                      blue: .random(in: 0...1),
                                      alpha: 1.0)
            
            randomColor.setFill()
            barPath.fill()
        }
    }
}
