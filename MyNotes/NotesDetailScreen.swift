//
//  NotesDetailScreen.swift
//  MyNotes
//
//  Created by User on 03/08/22.
//

import Foundation
import UIKit
import SwiftUI
import YPImagePicker

enum OperationMode {
    case add
    case update
}

class NotesDetailScreen: UIViewController {
    let appContext =  ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    public var mode: OperationMode = .add
    public var model:Notes?
    var notes: [Notes] = []
    private var scrollView: UIScrollView?
    private var contentView: UIView?
    private var closeButton: UIButton?
    private var dateLabel: UILabel?
    private var checkMarkButton: UIButton?
    public var noteID: Int = -1
    private var locationLabel: UILabel?
    private var titleLabel: UITextField?
    private var photo: UIImageView?
    private var photoHeightAnchor: NSLayoutConstraint?
    private var photoTopAnchor: NSLayoutConstraint?
    private var notesDescription: UITextView?
    private var floatingView: UIView?
    private var addImageButton: UIButton?
    private var addLocationButton: UIButton?
    private var changeThemeButton: UIButton?
    private var shareButton: UIButton?
    private var locationString = ""
    private var themeColor = "#cdcdcd"
    public var reloadCollectionViewData:(()->())?
    var note:Notes!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = model{
            self.note = note
        }
        if let sheetController = self.presentationController as? UISheetPresentationController {
            sheetController.detents = [.medium(), .large()]
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 30.0
        }
        setupUI()
        setConstraints()
        initialise()
        self.view.backgroundColor = hexStringToUIColor(hex: self.themeColor)
    }
    
    private func initialise() {
        //fetchNotes()
        
        if let model = model{
            self.titleLabel?.text = self.model?.title
            self.notesDescription?.text = self.model?.subtitle
            self.view.backgroundColor = hexStringToUIColor(hex: self.model?.theme ?? "#ffffff")
            self.locationLabel?.text = self.model?.location
            self.themeColor = (self.model?.theme ?? "#ffffff")
            self.photo?.image = UIImage(data: self.model?.photo ?? Data())
        }
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
        
        
        dateLabel = UILabel()
        dateLabel?.text = ""
        dateLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentView!.addSubview(dateLabel!)
        
        
        checkMarkButton = UIButton()
        checkMarkButton!.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        checkMarkButton!.imageView!.tintColor = UIColor.black
        checkMarkButton!.addTarget(self, action: #selector(saveAndCloseNote), for: .touchUpInside)
        contentView!.addSubview(checkMarkButton!)
        
        
        locationLabel = UILabel()
        locationLabel?.text = ""
        locationLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        contentView!.addSubview(locationLabel!)
        
        
        titleLabel = UITextField()
        titleLabel?.placeholder = "Title"
        titleLabel?.borderStyle = .none
        titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        contentView!.addSubview(titleLabel!)
        
        
        photo = UIImageView()
        photo?.image = UIImage(named: "")
        photo?.contentMode = .scaleAspectFit
        contentView!.addSubview(photo!)
        
        
        notesDescription = UITextView()
        notesDescription?.font = UIFont.systemFont(ofSize: 15)
        notesDescription?.textAlignment = .justified
        notesDescription?.isScrollEnabled = false
        notesDescription?.backgroundColor = UIColor.clear
        self.contentView!.addSubview(notesDescription!)
        
        
        floatingView = UIView()
        floatingView?.backgroundColor = UIColor.systemGray5
        floatingView?.layer.cornerRadius = 25.0
        self.view.addSubview(floatingView!)
        
        
        addImageButton = UIButton()
        addImageButton!.setImage(UIImage(systemName: "photo.fill.on.rectangle.fill"), for: .normal)
        addImageButton!.imageView!.tintColor = UIColor.black
        addImageButton!.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        floatingView!.addSubview(addImageButton!)
        
        
        addLocationButton = UIButton()
        addLocationButton!.setImage(UIImage(systemName: "location.fill"), for: .normal)
        addLocationButton!.imageView!.tintColor = UIColor.black
        addLocationButton!.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        floatingView!.addSubview(addLocationButton!)
        
        
        changeThemeButton = UIButton()
        changeThemeButton!.setImage(UIImage(systemName: "paintpalette.fill"), for: .normal)
        changeThemeButton!.imageView!.tintColor = UIColor.black
        changeThemeButton!.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        floatingView!.addSubview(changeThemeButton!)
        
        
        shareButton = UIButton()
        shareButton!.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        shareButton!.imageView!.tintColor = UIColor.black
        shareButton!.addTarget(self, action: #selector(shareNote), for: .touchUpInside)
        floatingView!.addSubview(shareButton!)
        
        
        switch mode {
        case .add:
            titleLabel?.text = "Title"
            notesDescription?.text = "Notes"
            break
        case .update:
//            titleLabel?.text = "Title"
//            notesDescription?.text = "Notes"
            self.note =  model
            break
        }
    }
    
    private func setConstraints() {
        scrollView?.translatesAutoresizingMaskIntoConstraints = false
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        closeButton?.translatesAutoresizingMaskIntoConstraints = false
        closeButton?.imageView?.translatesAutoresizingMaskIntoConstraints = false
        dateLabel?.translatesAutoresizingMaskIntoConstraints = false
        checkMarkButton?.translatesAutoresizingMaskIntoConstraints = false
        checkMarkButton?.imageView?.translatesAutoresizingMaskIntoConstraints = false
        locationLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        notesDescription?.translatesAutoresizingMaskIntoConstraints = false
        floatingView?.translatesAutoresizingMaskIntoConstraints = false
        addImageButton?.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton?.translatesAutoresizingMaskIntoConstraints = false
        changeThemeButton?.translatesAutoresizingMaskIntoConstraints = false
        shareButton?.translatesAutoresizingMaskIntoConstraints = false
        photo?.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        
        
        dateLabel?.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 13).isActive = true
        dateLabel?.leadingAnchor.constraint(greaterThanOrEqualTo: closeButton!.trailingAnchor, constant: 10).isActive = true
        dateLabel?.trailingAnchor.constraint(lessThanOrEqualTo: checkMarkButton!.leadingAnchor, constant: -10).isActive = true
        dateLabel?.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        
        
        checkMarkButton?.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 5).isActive = true
        checkMarkButton?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        
        checkMarkButton?.imageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkButton?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkButton?.imageView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkButton?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        locationLabel?.topAnchor.constraint(equalTo: closeButton!.bottomAnchor, constant: 20).isActive = true
        locationLabel?.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        
        
        titleLabel?.topAnchor.constraint(equalTo: locationLabel!.bottomAnchor, constant: 30).isActive = true
        titleLabel?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        
        
        photoTopAnchor = (self.photo?.topAnchor.constraint(equalTo: titleLabel!.bottomAnchor, constant: 0))!
        photoTopAnchor?.isActive = true
        self.photo?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        self.photo?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        self.photo?.widthAnchor.constraint(equalToConstant: 200).isActive = true
        photoHeightAnchor = (self.photo?.heightAnchor.constraint(equalToConstant: 0))!
        photoHeightAnchor!.isActive = true
        if let note = note{
            if let photo = note.photo, photo.isEmpty == false  {
                self.photo?.image = UIImage(data: note.photo!)
                self.photoHeightAnchor?.constant = 150
                self.photoTopAnchor?.constant = 20
            }
            
            if let date = note.editTime, date.isEmpty == false  {
                self.dateLabel?.text = "\(date)"
            }
        }
        
        notesDescription?.topAnchor.constraint(equalTo: self.photo!.bottomAnchor, constant: 20).isActive = true
        
        
        notesDescription?.leadingAnchor.constraint(equalTo: contentView!.leadingAnchor, constant: 20).isActive = true
        notesDescription?.trailingAnchor.constraint(equalTo: contentView!.trailingAnchor, constant: -20).isActive = true
        notesDescription?.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor, constant: -20).isActive = true
        
        
        floatingView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        floatingView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        floatingView?.widthAnchor.constraint(equalToConstant: 200).isActive = true
        floatingView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        addImageButton?.leadingAnchor.constraint(equalTo: floatingView!.leadingAnchor, constant: 22.5).isActive = true
        addImageButton?.centerYAnchor.constraint(equalTo: floatingView!.centerYAnchor).isActive = true
        
        
        addLocationButton?.leadingAnchor.constraint(equalTo: addImageButton!.trailingAnchor, constant: 20).isActive = true
        addLocationButton?.centerYAnchor.constraint(equalTo: floatingView!.centerYAnchor).isActive = true
        
        
        changeThemeButton?.leadingAnchor.constraint(equalTo: addLocationButton!.trailingAnchor, constant: 20).isActive = true
        changeThemeButton?.centerYAnchor.constraint(equalTo: floatingView!.centerYAnchor).isActive = true
        
        
        shareButton?.leadingAnchor.constraint(equalTo: changeThemeButton!.trailingAnchor, constant: 20).isActive = true
        shareButton?.centerYAnchor.constraint(equalTo: floatingView!.centerYAnchor).isActive = true
    }
    
    @objc func closeNote() {
        self.dismiss(animated: true)
    }
    
    
    // final change to core data
    @objc func saveAndCloseNote() {
        let title = titleLabel?.text!
        let subtitle = notesDescription?.text!
        let location = locationString
        let colorTheme = themeColor
        
        //let note = Notes()
        if mode == .add{
            addNote(title: title!, subTitle: subtitle, location: location, theme: colorTheme)
        }else{
            updateNote(title: title!, subTitle: subtitle!, location: location, theme: colorTheme)
        }
    
        
        self.dismiss(animated: true)
    }
    
    @objc func addImage() {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker,weak self] items, _ in
            if let img = items.singlePhoto {
                self?.photo?.image = img.image
                self?.photo?.contentMode = .scaleAspectFit
//                photoHeightAnchor.isActive = false
                self?.photoHeightAnchor!.constant = 150
//                photoHeightAnchor = self?.photo?.heightAnchor.constraint(equalToConstant: 150)
//                photoHeightAnchor.isActive = true
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @objc func shareNote() {
        let text = "Sometext"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
//        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ] //if want to exclude some activities
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func addLocation() {
        let vc = AddLocationVC()
        vc.locationSetting = { [weak self] location in
            self?.locationString = location
            self?.locationLabel?.text = location
        }
//        vc.updateNotesVC = { [weak self] in
//           // self?.fetchNotes()
//        }
        
        self.present(vc, animated: true) {
            //self.fetchNotes()
        }
    }
    
    @objc func changeTheme() {
        let vc = ThemeSelectorVC()
        vc.completionHandler = { selectedTheme in
            self.themeColor =  selectedTheme.rawValue
            self.view.backgroundColor = hexStringToUIColor(hex: self.themeColor)
//            UIApplication.shared.statusBarView?.backgroundColor = hexStringToUIColor(hex: self.themeColor)
            
        }
        
        self.present(vc, animated: true) {
            //self.fetchNotes()
        }
    }
}


extension NotesDetailScreen {
    
     func addNote(title:String? = "",subTitle:String? = "", location:String? = "", theme:String? = ""){
         let note = Notes(context: self.appContext)
         note.title = title
         note.subtitle = subTitle
         note.location = location
         note.theme  = theme
         note.date  = dateFromToday()
         note.editTime = dateFromToday()
         note.email = UserDefaults.standard.string(forKey: "email")
         if let imageData = photo?.image?.pngData() {
             note.photo = imageData
         }
         do{
             try self.appContext.save()
             reloadCollectionViewData?()
             print("note is saved")
         }catch{
             print("error in fetching data")
         }
         
     }
     
    func deletenote(){
        let item = Notes()
        appContext.delete(item)
        do{
            try appContext.save()
        }catch{
            print("Error in delete the item")
        }
    }
    
    func saveImageInCoreData(imgData:Data){
        note.photo = imgData
        do {
            try appContext.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }

    }
    
    
    func updateNote(title:String? = "",subTitle:String? = "", location:String? = "", theme:String? = ""){
        if title != ""{
            note.title = title!
        }
        if subTitle != ""{
            note.subtitle = subTitle!
        }
        if location != ""{
            note.location = location!
        }
        if theme != ""{
            note.theme = theme!
        }
        note.editTime = dateFromToday()
        note.date = dateFromToday()
        if let imageData = photo?.image?.pngData() {
            saveImageInCoreData(imgData: imageData)
        }
        do{
            try appContext.save()
            reloadCollectionViewData?()
        }
        catch{
            print("error in updating record")
        }
        
    }
    
}


extension UIApplication {

   var statusBarView: UIView? {
      return value(forKey: "statusBar") as? UIView
    }

}
