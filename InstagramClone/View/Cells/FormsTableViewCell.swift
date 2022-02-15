//
//  FormsTableViewCell.swift
//  FormsTableViewCell
//
//  Created by Nilesh Kumar on 14/02/22.
//

import UIKit

class FormsTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    public weak var delegate: FormsTableViewCellDelegate?
    
    private var models: editProfilelabels?

    static let identifier = "FormsTableViewCellIdentifier"
    
    private let myFormLabel: UILabel = {
        let myFormLabel = UILabel()
        myFormLabel.numberOfLines = 1
        myFormLabel.textColor = .label
        return myFormLabel
    }()
    
    private let myField: UITextField = {
        let myField = UITextField()
        myField.returnKeyType = .done
        return myField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myFormLabel)
        contentView.addSubview(myField)
        myField.delegate = self
        clipsToBounds = true
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(model: editProfilelabels){
        self.models = model
        myFormLabel.text = model.name
        myField.placeholder = model.placeHolder
        myField.text = model.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myFormLabel.frame = CGRect(x: 15, y: 0, width: contentView.width / 3, height: contentView.height)
        myField.frame = CGRect(x: 5 + myFormLabel.width, y: 0, width: contentView.width - 10 - myFormLabel.width, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myFormLabel.text = nil
        myField.placeholder = nil
        myField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        models?.value = textField.text
        guard let models = models else {
            return true
        }

        delegate?.didUpdateFieldValue(self, updatedField: models)
        textField.resignFirstResponder()
        return true
    }
    
}

protocol FormsTableViewCellDelegate: AnyObject{
    func didUpdateFieldValue(_ cell: FormsTableViewCell, updatedField: editProfilelabels?)
}
