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
    
    var valueLabel: UILabel = {
        var label = UILabel()
        label.text = "value"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var errorLabel: UILabel = {
        var label = UILabel()
        label.text = "error"
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
        
        view.addSubview(valueLabel)
        view.addSubview(errorLabel)
        view.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.valueLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            self.valueLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.valueLabel.bottomAnchor.constraint(equalTo: self.button.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.errorLabel.topAnchor.constraint(equalTo: self.valueLabel.topAnchor, constant: 40),
            self.errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.errorLabel.bottomAnchor.constraint(equalTo: self.button.topAnchor)
        ])
    }
    
    
    /// 버튼 클릭
    @objc func clickBtn() {
        print("click button")
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: getBiometry()) { (value, error) in
            print("value = \(value), error = \(error)")
            
            guard error == nil else {
                print("error = \(error?.localizedDescription)")
                
                // value 값 출력
                DispatchQueue.main.async {
                    self.valueLabel.text = value.description
                    self.errorLabel.text = error?.localizedDescription
                }
                
                return
            }
            
            // value 값 출력
            DispatchQueue.main.async {
                self.valueLabel.text = value.description
                self.errorLabel.text = error?.localizedDescription
            }
        }
    }
    
    /// 생체인증 타입 가져오기
    func getBiometry() -> String {
        print("context.biometryType = \(context.biometryType)")
        switch context.biometryType {
        case .faceID:
            return "Use Face ID instead of a password to access your account."
        case .touchID:
            return "Use Touch ID instead of a password to access your account."
        case .none:
            return "none"
        @unknown default:
            fatalError()
        }
    }
}

