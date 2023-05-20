//
//  PlanRequestViewController.swift
//  BodyFlasher
//
//  Created by Sachith Harshamal on 2023-05-07.
//
//  used swiftui library to create state vars
//

import UIKit
import AVKit
import AVFoundation

class PlanRequestViewController: UIViewController {
    
    var authDetail: LoginResponseDetail = LoginResponseDetail()
    
    // av player properties
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    let heightDataValues = 110...243
    let weightDataValues = 20...180
    
    var heightData: [String] = []
    var weightData: [String] = []
    var goalData = ["Cardio", "Shoulders", "Biceos", "Chest", "Abs", "Forearms", "Triceps", "Lower Back", "Quads", "Calves"]
    
    var workoutPlanRequest = WorkoutPlanRequest()
    var networkManager = NetworkManager()
    
    // initial elements
    let startButton : UIButton = {
        let button = UIButton()
        button.setTitle("GET MY PLAN", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(enableSurvey), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let formStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isHidden = true
        stackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 120, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // first form elements
    let firstQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What is your gender?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let maleButton : UIButton = {
        let button = UIButton()
        button.setTitle("MALE", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(setGenderMale), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let femaleButton : UIButton = {
        let button = UIButton()
        button.setTitle("FEMALE", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(setGenderFemale), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // second form elements
    let secondQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What is your birthday?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let agePicker : UIDatePicker = {
        // create a calender
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = 01
        minDateComponent.month = 01
        minDateComponent.year = 1950
        let minDate = calendar.date(from: minDateComponent)
        // create the date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = minDate! as Date
        datePicker.maximumDate = Date()
        datePicker.semanticContentAttribute = .forceRightToLeft
        datePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    let birthdayField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let ageSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processSecondForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // third form elements
    let thirdQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What's your height?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let heightPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    let heightField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let heightSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processThirdForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // fourth form elements
    let fourthQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What's your weight?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let weightPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    let weightField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let weightSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processFourthForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // fifth form elements
    let fifthQuestionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "What's your fitness goal?"
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let goalPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    let goalField : UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let goalSubmitButton : UIButton = {
        let button = UIButton()
        button.setTitle("PROCESS", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(processFifthForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // sixth form elements
    let generatePlanInfoLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 22.0)
        label.text = "All set! Let's generate your plan!"
        label.backgroundColor = UIColor.clear
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let generatePlanButton : UIButton = {
        let button = UIButton()
        button.setTitle("GENERATE PLAN", for: .normal)
        button.titleLabel?.font = UIFont(name:"AppleSDGothicNeo-Bold", size: 17.0)
        button.backgroundColor = UIColor(named: "dark-red")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(generatePlan), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {

        let theURL = Bundle.main.url(forResource:"home-vid", withExtension: "mov")

        avPlayer = AVPlayer(url: theURL!)
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayerLayer.frame = self.view.layer.bounds
        
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        // hide default back icon
        self.navigationItem.setHidesBackButton(true, animated: true)

        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: .AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
        
        // initiate data sources
        heightData = heightDataValues.map(String.init)
        weightData = weightDataValues.map(String.init)
        
        // initialize stack views
        formStack.addArrangedSubview(firstQuestionLabel)
        formStack.addArrangedSubview(maleButton)
        formStack.addArrangedSubview(femaleButton)
        
        // add components
        view.addSubview(formStack)
        view.addSubview(startButton)
        setupConstraintsFirstForm()
    }

    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    @objc func enableSurvey() {
        formStack.isHidden = false
        startButton.isHidden = true
    }
    
    @objc func setGenderMale() {
        // set struct instance value
        workoutPlanRequest.gender = "Male"
        processFirstForm()
    }
    
    @objc func setGenderFemale() {
        // set struct instance value
        workoutPlanRequest.gender = "Female"
        processFirstForm()
    }
    
    func processFirstForm() {
        formStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        arrangeSecondForm()
    }
    
    @objc func arrangeSecondForm() {
        createBirthdayPicker()
        // initialize stack views
        formStack.addArrangedSubview(secondQuestionLabel)
        formStack.addArrangedSubview(birthdayField)
        formStack.addArrangedSubview(ageSubmitButton)
        
        setupConstraintsSecondForm()
    }
    
    func createBirthdayPicker() {
        birthdayField.inputView = agePicker
        birthdayField.inputAccessoryView = createDatePickerToolBar()
    }
    
    func createDatePickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setBirthday))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setBirthday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.birthdayField.text = dateFormatter.string(from: agePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func processSecondForm() {
        // set struct instance value
        workoutPlanRequest.birthday = agePicker.date
        // clear form and proceed
        formStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        arrangeThirdForm()
    }
    
    @objc func arrangeThirdForm() {
        createHeightPicker()
        // initialize stack views
        formStack.addArrangedSubview(thirdQuestionLabel)
        formStack.addArrangedSubview(heightField)
        formStack.addArrangedSubview(heightSubmitButton)
        
        setupConstraintsThirdForm()
    }
    
    func createHeightPicker() {
        heightField.inputView = heightPicker
        heightField.inputAccessoryView = createHeightPickerToolBar()
        
        heightPicker.delegate = self
        heightPicker.dataSource = self
        
        heightPicker.tag = 1
    }
    
    func createHeightPickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setHeight))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setHeight() {
        self.heightField.text = heightData[heightPicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func processThirdForm() {
        // set struct instance value
        workoutPlanRequest.height = Int(heightField.text!)
        // clear form and proceed
        formStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        arrangeFourthForm()
    }
    
    @objc func arrangeFourthForm() {
        createWeightPicker()
        // initialize stack views
        formStack.addArrangedSubview(fourthQuestionLabel)
        formStack.addArrangedSubview(weightField)
        formStack.addArrangedSubview(weightSubmitButton)
        
        setupConstraintsFourthForm()
    }
    
    func createWeightPicker() {
        weightField.inputView = weightPicker
        weightField.inputAccessoryView = createWeightPickerToolBar()
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        
        weightPicker.tag = 2
    }
    
    func createWeightPickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setWeight))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setWeight() {
        self.weightField.text = weightData[weightPicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func processFourthForm() {
        // set struct instance value
        workoutPlanRequest.weight = Int(weightField.text!)
        // clear form and proceed
        formStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        arrangeFifthForm()
    }
    
    @objc func arrangeFifthForm() {
        createGoalPicker()
        // initialize stack views
        formStack.addArrangedSubview(fifthQuestionLabel)
        formStack.addArrangedSubview(goalField)
        formStack.addArrangedSubview(goalSubmitButton)
        
        setupConstraintsFifthForm()
    }
    
    func createGoalPicker() {
        goalField.inputView = goalPicker
        goalField.inputAccessoryView = createGoalPickerToolBar()
        
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        goalPicker.tag = 3
    }
    
    func createGoalPickerToolBar() -> UIToolbar {
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(setGoal))
        toolBar.setItems([doneBtn], animated: true)
        
        return toolBar
    }
    
    @objc func setGoal() {
        self.goalField.text = goalData[goalPicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    @objc func processFifthForm() {
        // set struct instance value
        workoutPlanRequest.goal = goalField.text!
        // clear form and proceed
        formStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        arrangeSixthForm()
    }
    
    @objc func arrangeSixthForm() {
        // initialize stack views
        formStack.addArrangedSubview(generatePlanInfoLabel)
        formStack.addArrangedSubview(generatePlanButton)
        
        setupConstraintsSixthForm()
    }
    
    @objc func generatePlan() {
        // send request
        sendWorkoutPlanRequest()
    }
    
    func sendWorkoutPlanRequest() {
        let waitingIndicator = self.waitingIndicator()
//        let status = networkManager.sendWorkoutPlanRequest(planRequest: self.workoutPlanRequest)
//        if (status) {
//            self.killWaitingIndicator(waitingIndicator: waitingIndicator)
//            // initialize home view
//            let homeVC = HomeViewController()
//            self.navigationController?.pushViewController(homeVC, animated: true)
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.killWaitingIndicator(waitingIndicator: waitingIndicator)
            // initialize home view
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func setupConstraintsFirstForm() {
        maleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        maleButton.topAnchor.constraint(equalTo: firstQuestionLabel.bottomAnchor, constant: 40).isActive = true
        maleButton.bottomAnchor.constraint(equalTo: femaleButton.topAnchor, constant: -20).isActive = true
        
        femaleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        formStack.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -50).isActive = true
        formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        formStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupConstraintsSecondForm() {
        secondQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 10).isActive = true
        
        birthdayField.bottomAnchor.constraint(equalTo: ageSubmitButton.topAnchor, constant: -50).isActive = true
        birthdayField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        birthdayField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        birthdayField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        ageSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupConstraintsThirdForm() {
        thirdQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 10).isActive = true
        
        heightField.bottomAnchor.constraint(equalTo: heightSubmitButton.topAnchor, constant: -50).isActive = true
        heightField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        heightField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        heightField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        heightSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupConstraintsFourthForm() {
        fourthQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 10).isActive = true
        
        weightField.bottomAnchor.constraint(equalTo: weightSubmitButton.topAnchor, constant: -50).isActive = true
        weightField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        weightField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        weightField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        weightSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupConstraintsFifthForm() {
        fifthQuestionLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 10).isActive = true
        
        goalField.bottomAnchor.constraint(equalTo: goalSubmitButton.topAnchor, constant: -50).isActive = true
        goalField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        goalField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        goalField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        goalSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupConstraintsSixthForm() {
        generatePlanInfoLabel.topAnchor.constraint(equalTo: formStack.topAnchor, constant: 10).isActive = true
        
        generatePlanButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

extension PlanRequestViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return heightData.count
        case 2:
            return weightData.count
        case 3:
            return goalData.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return heightData[row]
        case 2:
            return weightData[row]
        case 3:
            return goalData[row]
        default:
            return "No Data"
        }
    }
}

extension PlanRequestViewController {
    
    func waitingIndicator() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func killWaitingIndicator(waitingIndicator: UIAlertController) {
        DispatchQueue.main.async {
            waitingIndicator.dismiss(animated: true, completion: nil)
        }
    }
}
