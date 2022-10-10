//
//  ThemeSelectorVC.swift
//  MyNotes
//
//  Created by User on 04/08/22.
//

import Foundation
import UIKit

class ThemeSelectorVC: UIViewController {
    
    private var scrollView: UIScrollView?
    private var contentView: UIView?
    private var closeButton: UIButton?
    private var descriptionLabel: UILabel?
    private var themeButtonOne: UIButton?
    private var themeButtonTwo: UIButton?
    private var themeButtonThree: UIButton?
    private var themeButtonFour: UIButton?
    private var themeButtonFive: UIButton?
    private var themeButtonSix: UIButton?
    private var saveButton: UIButton?
    public var theme:Themes = .systemGray4
    
    var completionHandler: ((Themes)->())?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // this is almost code repetition all over the code. Try to do at a common place
        if let sheetController = self.presentationController as? UISheetPresentationController {
            sheetController.detents = [.medium()]
            sheetController.preferredCornerRadius = 30.0
        }
        
        resetSelectedTheme()
        
        initialise()
        setupUI()
        setConstraints()
    }
    
    private func initialise() {
    }
    
    private func setupUI() {
        scrollView = UIScrollView()
        contentView = UIView()
        view.addSubview(scrollView!)
        scrollView?.addSubview(contentView!)
        view.backgroundColor = UIColor.white
        
        
        closeButton = UIButton()
        closeButton!.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        closeButton!.imageView!.tintColor = UIColor.black
        closeButton!.addTarget(self, action: #selector(closeNote), for: .touchUpInside)
        contentView!.addSubview(closeButton!)
        
        
        descriptionLabel = UILabel()
        descriptionLabel?.text = "Select theme color for this entry"
        descriptionLabel?.font = UIFont.systemFont(ofSize: 17)
        self.contentView!.addSubview(descriptionLabel!)
        

        
        
        themeButtonOne = UIButton()
        themeButtonOne?.backgroundColor =  hexStringToUIColor(hex: Themes.systemGray4.rawValue)
        themeButtonOne?.layer.cornerRadius = 17.5
        themeButtonOne?.layer.borderColor = UIColor.black.cgColor
        themeButtonOne!.addTarget(self, action: #selector(themeOne), for: .touchUpInside)
        contentView!.addSubview(themeButtonOne!)
        
        
        themeButtonTwo = UIButton()
        themeButtonTwo?.backgroundColor = hexStringToUIColor(hex: Themes.systemGray2.rawValue)
        themeButtonTwo?.layer.cornerRadius = 17.5
        themeButtonTwo?.layer.borderColor = UIColor.black.cgColor
        themeButtonTwo!.addTarget(self, action: #selector(themeTwo), for: .touchUpInside)
        contentView!.addSubview(themeButtonTwo!)
        
        
        themeButtonThree = UIButton()
        themeButtonThree?.backgroundColor = hexStringToUIColor(hex: Themes.black.rawValue)
        themeButtonThree?.layer.cornerRadius = 17.5
        themeButtonThree?.layer.borderColor = UIColor.black.cgColor
        themeButtonThree!.addTarget(self, action: #selector(themeThree), for: .touchUpInside)
        contentView!.addSubview(themeButtonThree!)
        
        
        themeButtonFour = UIButton()
        themeButtonFour?.backgroundColor = hexStringToUIColor(hex: Themes.systemGray.rawValue)
        themeButtonFour?.layer.cornerRadius = 17.5
        themeButtonFour?.layer.borderColor = UIColor.black.cgColor
        themeButtonFour!.addTarget(self, action: #selector(themeFour), for: .touchUpInside)
        contentView!.addSubview(themeButtonFour!)
        
        
        themeButtonFive = UIButton()
        themeButtonFive?.backgroundColor = hexStringToUIColor(hex: Themes.darkGray.rawValue)
        themeButtonFive?.layer.cornerRadius = 17.5
        themeButtonFive?.layer.borderColor = UIColor.black.cgColor
        themeButtonFive!.addTarget(self, action: #selector(themeFive), for: .touchUpInside)
        contentView!.addSubview(themeButtonFive!)
        
        
        themeButtonSix = UIButton()
        themeButtonSix?.backgroundColor = hexStringToUIColor(hex: Themes.lightGray.rawValue)
        themeButtonSix?.layer.cornerRadius = 17.5
        themeButtonSix?.layer.borderColor = UIColor.black.cgColor
        themeButtonSix!.addTarget(self, action: #selector(themeSix), for: .touchUpInside)
        contentView!.addSubview(themeButtonSix!)
        
        
        saveButton = UIButton()
        saveButton?.setTitle("Save", for: .normal)
        saveButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        saveButton?.setTitleColor(UIColor.black, for: .normal)
        saveButton?.backgroundColor = UIColor.systemGray4
        saveButton?.layer.cornerRadius = 25.0
        saveButton!.addTarget(self, action: #selector(closeNote), for: .touchUpInside)
        contentView!.addSubview(saveButton!)
    }
    
    private func setConstraints() {
        scrollView?.translatesAutoresizingMaskIntoConstraints = false
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        closeButton?.translatesAutoresizingMaskIntoConstraints = false
        closeButton?.imageView?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        themeButtonOne?.translatesAutoresizingMaskIntoConstraints = false
        themeButtonTwo?.translatesAutoresizingMaskIntoConstraints = false
        themeButtonThree?.translatesAutoresizingMaskIntoConstraints = false
        themeButtonFour?.translatesAutoresizingMaskIntoConstraints = false
        themeButtonFive?.translatesAutoresizingMaskIntoConstraints = false
        themeButtonSix?.translatesAutoresizingMaskIntoConstraints = false
        saveButton?.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        scrollView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        
        contentView?.topAnchor.constraint(equalTo: scrollView!.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        contentView?.bottomAnchor.constraint(equalTo: scrollView!.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
        contentView?.leadingAnchor.constraint(equalTo: scrollView!.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        contentView?.trailingAnchor.constraint(equalTo: scrollView!.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        contentView?.widthAnchor.constraint(equalTo: scrollView!.frameLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        
        
        closeButton?.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 5).isActive = true
        closeButton?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        
        closeButton?.imageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton?.imageView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        descriptionLabel?.topAnchor.constraint(equalTo: closeButton!.bottomAnchor, constant: 20).isActive = true
        descriptionLabel?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        descriptionLabel?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        
        
        themeButtonOne?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        themeButtonOne?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        themeButtonOne?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        themeButtonOne?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        themeButtonTwo?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        themeButtonTwo?.leadingAnchor.constraint(equalTo: themeButtonOne!.trailingAnchor, constant: 25).isActive = true
        themeButtonTwo?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        themeButtonTwo?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        themeButtonThree?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        themeButtonThree?.leadingAnchor.constraint(equalTo: themeButtonTwo!.trailingAnchor, constant: 25).isActive = true
        themeButtonThree?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        themeButtonThree?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        themeButtonFour?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        themeButtonFour?.leadingAnchor.constraint(equalTo: themeButtonThree!.trailingAnchor, constant: 25).isActive = true
        themeButtonFour?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        themeButtonFour?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        themeButtonFive?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        themeButtonFive?.leadingAnchor.constraint(equalTo: themeButtonFour!.trailingAnchor, constant: 25).isActive = true
        themeButtonFive?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        themeButtonFive?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        themeButtonSix?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        themeButtonSix?.leadingAnchor.constraint(equalTo: themeButtonFive!.trailingAnchor, constant: 25).isActive = true
        themeButtonSix?.trailingAnchor.constraint(lessThanOrEqualTo: contentView!.trailingAnchor, constant: -25).isActive = true
        themeButtonSix?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        themeButtonSix?.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        saveButton?.topAnchor.constraint(equalTo: themeButtonOne!.bottomAnchor, constant: 35).isActive = true
        saveButton?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        saveButton?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        saveButton?.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -20).isActive = true
        saveButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton?.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    /**
     case systemGray4 = "#cdcdcd"
     case systemGray2 = "000000"
     case black = "bcd03f"
     case systemGray = "e2a900"
     case darkGray = "#bdbdbd"
     case lightGray = "#cde123"
    */
    
    func resetSelectedTheme() {
        themeButtonOne?.layer.borderWidth = 0
        themeButtonTwo?.layer.borderWidth = 0
        themeButtonThree?.layer.borderWidth = 0
        themeButtonFour?.layer.borderWidth = 0
        themeButtonFive?.layer.borderWidth = 0
        themeButtonSix?.layer.borderWidth = 0
        
        switch theme {
        case .systemGray4:
            themeButtonOne?.layer.borderWidth = 2
        case .systemGray2:
            themeButtonTwo?.layer.borderWidth = 2
        case .black:
            themeButtonThree?.layer.borderWidth = 2
        case .systemGray:
            themeButtonFour?.layer.borderWidth = 2
        case .darkGray:
            themeButtonFive?.layer.borderWidth = 2
        case .lightGray:
            themeButtonSix?.layer.borderWidth = 2
        }
    }
    
    @objc func refreshNotes() { }
    
    @objc func closeNote() {
        completionHandler?(theme)
        self.dismiss(animated: true)
    }
    
    @objc func themeOne() {
        theme = .systemGray4
        resetSelectedTheme()
        //self.dismiss(animated: true)
    }
    
    @objc func themeTwo() {
        theme = .systemGray2
        resetSelectedTheme()
        //self.dismiss(animated: true)
    }
    
    @objc func themeThree() {
        theme = .black
        resetSelectedTheme()
        //self.dismiss(animated: true)
    }
    
    @objc func themeFour() {
        theme = .systemGray
        resetSelectedTheme()
        //self.dismiss(animated: true)
    }
    
    @objc func themeFive() {
        theme = .darkGray
        resetSelectedTheme()
        //self.dismiss(animated: true)
    }
    
    @objc func themeSix() {
        theme = .lightGray
        resetSelectedTheme()
        //self.dismiss(animated: true)
    }
}
