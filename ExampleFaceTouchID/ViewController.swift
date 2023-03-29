//
//  ViewController.swift
//  ExampleFaceTouchID
//
//  Created by 황재현 on 2023/03/22.
//

import UIKit
// 생체인증관련
import LocalAuthentication

class ViewController: UIViewController {
    
    var label: UILabel = {
        var label = UILabel()
        label.text = "??"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var button: UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        button.setTitle("버튼", for: .normal)
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    let context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.button.topAnchor)
        ])
    }
    
    
    @objc func clickBtn() {
        print("asdasd")
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "인증해보자") { (value, error) in
            print("value = \(value), error = \(error)")
            
            guard error == nil else {
                print("error = \(error?.localizedDescription)")
                
                // value값 출력
                DispatchQueue.main.async {
                    self.label.text = value.description
                }
                
                return
            }
            
            // value값 출력
            DispatchQueue.main.async {
                self.label.text = value.description
            }
        }
    }
}

