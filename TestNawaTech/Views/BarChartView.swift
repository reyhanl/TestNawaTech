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
    var financeAbr: FinanceAbbreviation = .thousand
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        guard !dataPoints.isEmpty, values.count == dataPoints.count else {
            return
        }
        
        let maxValue = values.max() == 0 ? 1000000:(values.max() ?? 0)
        var minX: CGFloat = 15.0
        
        let lineHeight = (rect.height - 30 - minX)
        let maxXForChart = (rect.width - 30 - minX)
        let barWidth =  maxXForChart / CGFloat(dataPoints.count)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: lineHeight + minX))
        
        for (index, value) in values.enumerated() {
            let barHeight =  lineHeight * (value / maxValue)
            let barOriginX = CGFloat(index) * barWidth
            let barOriginY = lineHeight - barHeight + minX
            
            let text = dataPoints[index]
            let color = UIColor.primaryForegroundColor
            let fontSize: CGFloat = 12.0
            let font = UIFont.systemFont(ofSize: fontSize)
            let widthOfText = text.width(withConstrainedHeight: 100, font: font)
            
            let linePoint = CGPoint(x: barOriginX, y: barOriginY)
            let textX = barOriginX - widthOfText / 2 < 0 ? 0:barOriginX - widthOfText / 2
            let textPoint = CGPoint(x: textX, y: lineHeight + 10 + minX)
            NSAttributedString(attributedString: .init(string: text, attributes: [.font: font, .foregroundColor: color])).draw(at: textPoint)
            path.addLine(to: linePoint)
            let randomColor = UIColor.primaryButton
            
            let numberPoint = CGPoint(x: maxXForChart - 12, y: lineHeight - (CGFloat(index) / CGFloat(values.count - 1 ) * CGFloat(lineHeight)) - 6 + minX)
            let value = CGFloat(index) / CGFloat(values.count - 1) * maxValue
            let valueStr = value.giveAutoFinanceAbbreviations()
            NSAttributedString(attributedString: .init(string: valueStr, attributes: [.font: font, .foregroundColor: color])).draw(at: numberPoint)
            
            let thinLinePointMinX = CGPoint(x: 0, y: numberPoint.y + fontSize / 2)
            let thinLinePointMaxX = CGPoint(x: maxXForChart, y: numberPoint.y + fontSize / 2)
            let thinLine = UIBezierPath()
            
            thinLine.move(to: thinLinePointMinX)
            thinLine.addLine(to: thinLinePointMaxX)
            thinLine.stroke(with: .normal, alpha: 0.2)
            thinLine.lineWidth = 0.5

            randomColor.setStroke()
            randomColor.setFill()
            
            path.lineWidth = 3
            path.stroke()
        }
    }
}
