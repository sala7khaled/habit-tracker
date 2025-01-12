//
//  HabitCell.swift
//  habit-tracker
//
//  Created by Salah Khaled on 12/01/2025.
//

import UIKit

protocol HabitCellDelegate: AnyObject {
    func didCompleteHabit(at indexPath: IndexPath)
}

class HabitCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    // MARK: - Properties
    weak var delegate: HabitCellDelegate?
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Methods
    func configure(habit: HabitModel, isCompleted: Bool) {
        titleLabel.text = habit.title
        
        completeButton.tintColor = isCompleted ? .systemGreen : .lightGray
        completeButton.setImage(UIImage(systemName: isCompleted ? "checkmark.square.fill" : "square"), for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func completeButtonClicked(_ sender: Any) {
        guard let indexPath = getIndexPath() else { return }
        delegate?.didCompleteHabit(at: indexPath)
    }
    
}
