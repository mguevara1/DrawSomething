//
//  ViewController.swift
//  DrawSomething
//
//  Created by Marco Guevara on 27/03/24.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    let blackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        return button
    }()
    
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        return slider
    }()
    
    fileprivate func setupLayout() {
        let colorStackView = UIStackView(arrangedSubviews: [blackButton, yellowButton, redButton, blueButton])
        colorStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, colorStackView, slider, clearButton])
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
        
        undoButton.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        
        blackButton.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        yellowButton.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        redButton.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .touchUpInside)
        slider.setValue(Float(canvas.getStrokeWidth()), animated: false)
        slider.tintColor = .black
        slider.thumbTintColor = .black
        
        setupLayout()
    }

    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    @objc fileprivate func handleColorChange(button: UIButton) {
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
        slider.tintColor = button.backgroundColor ?? .black
        slider.thumbTintColor = button.backgroundColor ?? .black
    }
    
    @objc fileprivate func handleSliderChange() {
        canvas.setStrokeWidth(strokeWidth: CGFloat(slider.value))
    }
}

