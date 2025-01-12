<img src="/screenshots/logo.svg" height="80">

# Habit Tracker

A habit tracking application built with Swift and Firebase. This app helps users create, manage, and track the completion of their daily habits while providing a seamless user experience.

---

## Features

- [x] **Create Habits:** Add new habits with a unique title.
- [x] **Track Progress:** Mark habits as completed for specific dates.
- [x] **View Habits:** Display a list of all habits sorted alphabetically.
- [x] **Habit Status:** Indicate completed and incomplete habits visually.
- [x] **Swipe to Delete:** Remove habits with a swipe gesture.
- [x] **Firebase Integration:** All data is stored and managed using Firebase Realtime Database.

---

## Screen recording
https://github.com/user-attachments/assets/27e21b25-f4b3-43b4-8302-f54a0ded5ba3

---

## Screenshots

| Splash | Username | Habits | Date | Add Habit |
| --- | --- | --- | --- | --- |
| <img src="/screenshots/1.png" height="320"> | <img src="/screenshots/2.png" height="320"> | <img src="/screenshots/3.png" height="320"> | <img src="/screenshots/4.png" height="320"> | <img src="/screenshots/5.png" height="320"> |


---


## Code Highlights

### FirebaseManager
Centralized class to handle all Firebase operations, including:
- Adding habits
- Fetching all habits
- Completing habits
- Deleting habits and associated progress

#### Example
```swift
FirebaseManager.shared.addHabit(habitTitle: "Exercise") { error in
    if let error = error {
        print("Failed to add habit: \(error)")
    } else {
        print("Habit added successfully")
    }
}
```

### Swipe to Delete
Implemented in the `HomeController` to allow users to delete habits with a swipe gesture.

#### Example
```swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        let habit = viewModel.getHabit(at: indexPath.row)
        viewModel.deleteHabit(habitId: habit.id) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "Error", message: error)
            } else {
                self?.removeHabitFromList(at: indexPath)
            }
        }
    }
}
```

---

## Contact

Created by Salah Khaled. Feel free to reach out for collaboration.

- **Email:** sala7khalad@gmail.com
- **LinkedIn:** [Salah Khaled](https://linkedin.com/in/sala7khalaed)

