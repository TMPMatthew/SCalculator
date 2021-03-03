//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Matthew on 02.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?
    
    enum Operation{
        case add, substract, multiply, divide
        
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 90)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }

    private func setupNumberPad()
    {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(zeroPressed), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        for x in 0..<3
        {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            button1.backgroundColor = .white
            button1.setTitle("\(x+1)", for: .normal)
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numpadPress(_:)), for: .touchUpInside)
            holder.addSubview(button1)
        }
        for x in 0..<3
        {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.setTitle("\(x+4)", for: .normal)
            button2.tag = x+5
            button2.addTarget(self, action: #selector(numpadPress(_:)), for: .touchUpInside)
            holder.addSubview(button2)
        }
        for x in 0..<3
        {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.setTitle("\(x+7)", for: .normal)
            button3.tag = x+8
            button3.addTarget(self, action: #selector(numpadPress(_:)), for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: view.frame.size.width-buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitle("Clear", for: .normal)
        holder.addSubview(clearButton)
        
        
        let operations = ["=", "+", "-", "x", "/"]
        for x in 0..<5
        {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize*CGFloat(x+1)), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = .orange
            button4.setTitle(operations[x], for: .normal)
            button4.titleLabel?.font = UIFont(name: "Helvetica", size: 35)
            button4.tag = x+1
            button4.addTarget(self, action: #selector(operationPress(_:)), for: .touchUpInside)
            
            holder.addSubview(button4)
        }
        
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110, width: view.frame.size.width-40, height: 100)
        holder.addSubview(resultLabel)
        
    //Actions buttons go beep boop
        
    clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)

    }
    @objc func clearResult()
    {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
    }
    
    @objc func numpadPress(_ sender: UIButton)
    {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0"
        {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text
        {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func zeroPressed()
    {
        if resultLabel.text != "0"
        {
            if let text = resultLabel.text
            {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func operationPress(_ sender: UIButton)
    {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0
        {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        
        if tag == 1
        {
            if let operation = currentOperations{
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text)
                {
                    secondNumber = value
                }

            switch operation {
            case .add:
                
                let result = firstNumber + secondNumber
                resultLabel.text = "\(result)"
                
                break
            case .substract:
                
                let result = firstNumber - secondNumber
                resultLabel.text = "\(result)"
                break
            case .multiply:
                
                let result = firstNumber * secondNumber
                resultLabel.text = "\(result)"
                break
            case .divide:
                
                let result = firstNumber / secondNumber
                resultLabel.text = "\(result)"
                break
            }
                
        }
            
        }
        else if tag == 2
        {
            currentOperations = .add
        }
        else if tag == 3
        {
            currentOperations = .substract
        }
        else if tag == 4
        {
            currentOperations = .multiply
        }
        else if tag == 5
        {
            currentOperations = .divide
        }

    }

}

