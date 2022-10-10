//
//  AddLocationVC.swift
//  MyNotes
//
//  Created by User on 04/08/22.
//

import Foundation
import UIKit
import SwiftUI
import MapKit
import CoreLocation

class AddLocationVC: UIViewController, CLLocationManagerDelegate {
    
    private var scrollView: UIScrollView?
    private var contentView: UIView?
    private var closeButton: UIButton?
    private var descriptionLabel: UILabel?
    private var manualLocationEntry: UITextField?
    private var orLabel: UILabel?
    private var fetchLocationButton: UIButton?
    private var saveButton: UIButton?
    let locationManager = CLLocationManager()
    var locationSetting:((String)->Void)?
    var updateNotesVC:(()->())?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetController = self.presentationController as? UISheetPresentationController {
            sheetController.detents = [.medium()]
            sheetController.preferredCornerRadius = 30.0
        }
        
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
        descriptionLabel?.text = "Add location to this entry"
        descriptionLabel?.font = UIFont.systemFont(ofSize: 17)
        self.contentView!.addSubview(descriptionLabel!)
        
        
        manualLocationEntry = UITextField()
        manualLocationEntry?.placeholder = "Enter Manually"
        manualLocationEntry?.borderStyle = .roundedRect
        manualLocationEntry?.font = UIFont.systemFont(ofSize: 16)
        contentView!.addSubview(manualLocationEntry!)
        
        
        orLabel = UILabel()
        orLabel?.text = "or"
        orLabel?.font = UIFont.systemFont(ofSize: 20)
        self.contentView!.addSubview(orLabel!)
        
        
        fetchLocationButton = UIButton()
        fetchLocationButton?.setTitle(" Take my Current Location", for: .normal)
        fetchLocationButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        fetchLocationButton?.setTitleColor(UIColor.black, for: .normal)
        fetchLocationButton?.backgroundColor = UIColor.systemGray4
        fetchLocationButton?.layer.cornerRadius = 15.0
        fetchLocationButton?.setImage(UIImage(systemName: "location.fill"), for: .normal)
        fetchLocationButton!.imageView!.tintColor = UIColor.black
        fetchLocationButton!.addTarget(self, action: #selector(fetchLocation), for: .touchUpInside)
        contentView!.addSubview(fetchLocationButton!)
        
        
        saveButton = UIButton()
        saveButton?.setTitle("Save", for: .normal)
        saveButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        saveButton?.setTitleColor(UIColor.black, for: .normal)
        saveButton?.backgroundColor = UIColor.systemGray4
        saveButton?.layer.cornerRadius = 25.0
        saveButton!.addTarget(self, action: #selector(saveLocation), for: .touchUpInside)
        contentView!.addSubview(saveButton!)
    }
    
    private func setConstraints() {
        scrollView?.translatesAutoresizingMaskIntoConstraints = false
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        closeButton?.translatesAutoresizingMaskIntoConstraints = false
        closeButton?.imageView?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        manualLocationEntry?.translatesAutoresizingMaskIntoConstraints = false
        orLabel?.translatesAutoresizingMaskIntoConstraints = false
        fetchLocationButton?.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        manualLocationEntry?.topAnchor.constraint(equalTo: descriptionLabel!.bottomAnchor, constant: 20).isActive = true
        manualLocationEntry?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        manualLocationEntry?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        
        manualLocationEntry?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        orLabel?.topAnchor.constraint(equalTo: manualLocationEntry!.bottomAnchor, constant: 15).isActive = true
        orLabel?.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        
        
        fetchLocationButton?.topAnchor.constraint(equalTo: orLabel!.bottomAnchor, constant: 15).isActive = true
        fetchLocationButton?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        fetchLocationButton?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        fetchLocationButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fetchLocationButton?.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        saveButton?.topAnchor.constraint(equalTo: fetchLocationButton!.bottomAnchor, constant: 35).isActive = true
        saveButton?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        saveButton?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        saveButton?.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -20).isActive = true
        saveButton?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton?.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func closeNote() {
        self.dismiss(animated: true)
       
    }
    
    @objc func fetchLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.locationManager.stopUpdatingLocation()
            self.manualLocationEntry?.text = "\(city), \(country)"
        }
    }
    
    @objc func saveLocation() {
        self.locationSetting?(self.manualLocationEntry?.text! ?? "")
        let vc = showAlertViewController(title: "Location", message: "Location has been saved") {
        }
        self.present(vc,animated: true)
    }
}
