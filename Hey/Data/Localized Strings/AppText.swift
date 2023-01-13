//
//  AppText.swift
//  Hey There
//
//  Created by Mu Yu on 1/11/23.
//

import Foundation

struct AppText {
    static var appName: String { "app_name".localized }
}

extension AppText {
    struct General {
        static var add: String { "general.add".localized }
        static var save: String { "general.save".localized }
        static var cancel: String { "Cancel" }
        static var delete: String { "Delete" }
        static var search: String { "Search" }
        static var pullToRefresh: String { "Pull to refresh" }
        static var goal: String { "Goal" }
        static var noData: String { "No data" }
        static var logout: String { "Log out" }
    }
}
// MARK: - Loading and Auth
extension AppText {
    struct Loading {
        static var title: String { "Loading" }
    }
    struct Auth {
        static var continueWithGoogle: String { "login_google_cta".localized }
        static var continueWithApple: String { "Continue with Apple" }
        static var emailPlaceholder: String { "Enter email" }
        static var passwordPlaceholder: String { "Enter password" }
        static var codePlaceholder: String { "Enter code" }
        static var actionButtonText: String { "Login" }
    }
}
// MARK: - Main Tab
extension AppText {
    struct MainTab {
        static var home: String { "Home" }
        static var chat: String { "Chat" }
        static var progress: String { "Progress" }
        static var me: String { "Me" }
    }
}
// MARK: - Home
extension AppText {
    struct Home {
        static var title: String { "Diary" }
        static var greetingTitle: String { "Hello, $0!" }
        static var upcomingSessionsSectionTitle: String { "Upcoming Sessions" }
        static var BookAgainSectionTitle: String { "Book It Again" }
        
        static var activeCaloriesTitle: String { "Burned" }
        static var activeCaloriesSubtitle: String { "active calories" }
        static var dailyStepsTitle: String { "Steps" }
        static var dailyStepsSubtitle: String { "Daily steps" }
        static var sleepHoursTitle: String { "Sleep" }
        static var sleepHoursSubtitle: String { "sleep hours" }
        static var waterIntakeTitle: String { "Water" }
        static var waterIntakeSubtitle: String { "water intake" }
        static var remaining: String { "Remaining" }
        static var consumed: String { "Consumed" }
        static var addFoodLog: String { "Add food" }
        static var addMeal: String { "Add meal" }
        static var editMeal: String { "Edit" }
        static var addJournal: String { "Add journal" }
        static var noData: String { "No data" }
        static var exercise: String { "Exercise" }
        static var journal: String { "Journal" }
    }
}
// MARK: - Unit
extension AppText {
    struct Unit {
        static var kcal: String { "kcal" }
        static var steps: String { "steps" }
        static var hours: String { "hours" }
        static var mililiter: String { "mL" }
        static var liter: String { "L" }
        static var day: String { "day" }
        static var days: String { "days" }
        static var minutes: String { "minutes" }
        static var minuteShort: String { "min" }
    }
}
// MARK: - Workout
extension AppText {
    struct Workout {
        static var newSession: String { "New session" }
        static var workoutRoutine: String { "Workout routine" }
        static var workoutRoutines: String { "Workout routines" }
        static var startTime: String { "Start time" }
        static var endTime: String { "End time" }
        static var note: String { "Note" }
        static var addExercise: String { "Add exercise" }
        static var startThisRoutine: String { "Start this routine" }
        static var addSet: String { "Add set" }
        static var weight: String { "Weight" }
        static var reps: String { "Reps" }
        static var selectExercise: String { "Select exercise" }
    }
}
// MARK: - Me
extension AppText {
    struct Me {
        static var account: String { "Account" }
        static var generalSettings: String { "General Settings" }
        static var goals: String { "Goals" }
        static var reminders: String { "Reminders" }
        static var appAndServices: String { "App and Services" }
        static var customization: String { "Customization" }
        static var editExercises: String { "Edit Exercises" }
        static var editMeals: String { "Edit Meals" }
        static var editRecipes: String { "Edit Recipes" }
        static var feedback: String { "Feedback" }
        static var sendFeedback: String { "Send Feedback" }
        static var helpAndSupport: String { "Help and Support" }
    }
}
