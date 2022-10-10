//
//  Notes_MainScreenViewController.swift
//  MyNotes
//
//  Created by User on 02/08/22.
//

import Foundation
import UIKit
import SwiftUI

class Notes_MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let appContext =  ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    public var notes: [Notes] = []
//    private var searchField: TextFieldWithPadding?
    private var notesCollectionView: UICollectionView?
    private var cellID = "Cell"
    private var addNotesButton: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialise()
        setupUI()
        setConstraints()
    }
    
    func fetchNotes(){
        var notes:[Notes] = []
        do{
            notes = try self.appContext.fetch(Notes.fetchRequest()).filter({ model in
                return model.email == UserDefaults.standard.string(forKey: "email")
            })
            
            self.notes = notes
            self.notesCollectionView?.reloadData()
        }catch{
             print("error in fetching records")
        }
        
    }
  
    
    private func initialise() {
        refreshNotes()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
//        searchField = TextFieldWithPadding(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
//        searchField!.placeholder = "Search"
//        searchField!.borderStyle = UITextField.BorderStyle.none
//        searchField!.layer.cornerRadius = 20.0 // width/2 for rounded corners
//        searchField!.layer.borderWidth = 1
//        searchField!.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
//        searchField!.backgroundColor = UIColor.systemGray5
//        view.addSubview(searchField!)
        
        let layout = UICollectionViewFlowLayout()
        
        notesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        notesCollectionView!.delegate = self
        notesCollectionView!.dataSource = self
        notesCollectionView!.register(Notes_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        notesCollectionView!.backgroundColor = UIColor.white
        notesCollectionView!.showsHorizontalScrollIndicator = false
        notesCollectionView!.showsVerticalScrollIndicator = false
        self.view.addSubview(notesCollectionView!)
        
        notesCollectionView!.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
        addNotesButton = UIButton()
        addNotesButton!.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addNotesButton!.imageView!.tintColor = UIColor.systemGray2
        addNotesButton!.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        view.addSubview(addNotesButton!)
        
    }
    
    private func setConstraints() {
//        searchField?.translatesAutoresizingMaskIntoConstraints = false
        notesCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        addNotesButton?.translatesAutoresizingMaskIntoConstraints = false
        addNotesButton?.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        
//        searchField?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        searchField?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        searchField?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        
//        notesCollectionView?.topAnchor.constraint(equalTo: searchField!.bottomAnchor, constant: 20).isActive = true
        notesCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true //TODO: remove this when show searchbar
        notesCollectionView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        notesCollectionView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        notesCollectionView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        
        addNotesButton?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        addNotesButton?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        addNotesButton?.imageView?.heightAnchor.constraint(equalToConstant: 70).isActive = true
        addNotesButton?.heightAnchor.constraint(equalToConstant: 70).isActive = true
        addNotesButton?.imageView?.widthAnchor.constraint(equalToConstant: 70).isActive = true
        addNotesButton?.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    @objc func refreshNotes() {
        fetchNotes()
    }
    
    @objc func addNote() {
        let vc = NotesDetailScreen()
        vc.mode = .add
        vc.reloadCollectionViewData = { [weak self] in
            self?.refreshNotes()
            self?.notesCollectionView?.reloadData()
        }
        self.present(vc, animated: true)
    }
    
    
    //MARK: ALL COLLECTIONVIEW METHODS START FROM HERE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.notes[indexPath.row]
        let cell = notesCollectionView!.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Notes_CollectionViewCell
        cell.note = model
        cell.initialise(model:model)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/2 - 10, height: 300 - 10)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        notesCollectionView!.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NotesDetailScreen()
        
        vc.mode = .update
        vc.model = self.notes[indexPath.row]
        vc.reloadCollectionViewData = { [weak self] in
            self?.refreshNotes()
            self?.notesCollectionView?.reloadData()
        }
        self.present(vc, animated: true)
    }
    
}
