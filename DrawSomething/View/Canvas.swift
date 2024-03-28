//
//  Canvas.swift
//  DrawSomething
//
//  Created by Marco Guevara on 27/03/24.
//

import UIKit

class Canvas: UIView {
    
    private var lines = [Line]()
    private var strokeColor: UIColor = .black
    private var strokeWidth: CGFloat = 5.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { line in
            context.setStrokeColor(line.strokeColor.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(strokeWidth: strokeWidth, strokeColor: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    public func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    public func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    public func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    public func setStrokeWidth(strokeWidth: CGFloat) {
        self.strokeWidth = strokeWidth
    }
    
    public func getStrokeWidth() -> CGFloat {
        return self.strokeWidth
    }
}
