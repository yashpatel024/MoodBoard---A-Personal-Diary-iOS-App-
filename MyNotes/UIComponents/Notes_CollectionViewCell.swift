//
//  Notes_CollectionViewCell.swift
//  MyNotes
//
//  Created by User on 03/08/22.
//

import Foundation
import UIKit

class Notes_CollectionViewCell: UICollectionViewCell {
    var note: Notes?
    var optionalHeightAnchor: NSLayoutConstraint?
    var optionalTopAnchor: NSLayoutConstraint?
    
    public func configureCell(title: String, noteDescription: String, images: [UIImage]?) {
        titleLabel.text = title
        noteDescriptionLabel.text = noteDescription
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.black
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let optionalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let noteDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    func addViews(){
       
        layer.cornerRadius = 15.0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(noteDescriptionLabel)
        addSubview(optionalImageView)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        optionalTopAnchor = optionalImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
        optionalTopAnchor?.isActive = true
        optionalImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        optionalImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20).isActive = true
        optionalImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        optionalHeightAnchor = optionalImageView.heightAnchor.constraint(equalToConstant: 0)
        optionalHeightAnchor?.isActive = true
        
        if let note  = note{
            if let photo = note.photo, photo.isEmpty == false  {
                optionalImageView.image = UIImage(data: note.photo!)
                optionalHeightAnchor?.constant = 75
                optionalTopAnchor?.constant = 15
            }
        }
        noteDescriptionLabel.topAnchor.constraint(equalTo: optionalImageView.bottomAnchor, constant: 10).isActive = true
        noteDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        noteDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        noteDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -15).isActive = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialise(model:Notes){
        self.titleLabel.text = model.title
        self.noteDescriptionLabel.text = model.subtitle
        //self.optionalImageView.image = UIImage(data: model.photo ?? Data())
        backgroundColor = hexStringToUIColor(hex: model.theme ?? "#ffffff")
        addViews()
    }

}
