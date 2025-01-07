extends Node
var questions : Array = []
var orgquestions : Array = []
var answers : Array = []
var questionumber : int = 1
var numberofquestions : float
var answerselected : float
var answerint : int
var clicks : int = 0
@onready var answer: Label = $Answer/Label
@onready var answer_2: Label = $Answer2/Label
@onready var answer_3: Label = $Answer3/Label
@onready var answer_4: Label = $Answer4/Label
@onready var question: TextEdit = $question
@onready var question_number_text: Label = $"question number"
@onready var results: Label = $results
@onready var home_button: TextureButton = $TextureButton



func _ready() -> void:
	randomize()
	orgquestions = SaveData.save_dict[SaveData.set_selected][0].duplicate()
	questions = SaveData.save_dict[SaveData.set_selected][0].duplicate()
	answers = SaveData.save_dict[SaveData.set_selected][1].duplicate()
	numberofquestions = questions.size()
	next_question()
	
	
func _on_answer_pressed() -> void:
	clicks+=1
	answerselected = 1
	if answerselected == answerint:
		questionumber+=1
		if questionumber < numberofquestions + 1:
			next_question()
		else:
			endtest()
		
func _on_answer_2_pressed() -> void:
	clicks+=1
	answerselected = 2
	if answerselected == answerint:
		questionumber+=1
		if questionumber < numberofquestions + 1:
			next_question()
		else:
			endtest()
	
func _on_answer_3_pressed() -> void:
	clicks+=1
	answerselected = 3
	if answerselected == answerint:
		questionumber+=1
		if questionumber < numberofquestions + 1:
			next_question()
		else:
			endtest()

func _on_answer_4_pressed() -> void:
	clicks+=1
	answerselected = 4
	if answerselected == answerint:
		questionumber+=1
		if questionumber < numberofquestions + 1:
			next_question()
		else:
			endtest()

func next_question() -> void:
	if answers.size() <= 4:
		for i in range(5-answers.size()):
			answers.append("")
	question.text = questions.pick_random()
	questions.erase(question.text)
	var AnswerString = answers[orgquestions.find(question.text)]
	answers.erase(AnswerString)
	answer.text = answers.pick_random()
	answers.erase(answer.text)
	answer_2.text = answers.pick_random()
	answers.erase(answer_2.text)
	answer_3.text = answers.pick_random()
	answers.erase(answer_3.text)
	answer_4.text = answers.pick_random()
	answers.erase(answer_4.text)
	var randnum = randi()%4 + 1
	if randnum == 1:
		answer.text = AnswerString
		answerint = randnum
	if randnum == 2:
		answer_2.text = AnswerString
		answerint = randnum
	if randnum == 3:
		answer_3.text = AnswerString
		answerint = randnum
	if randnum == 4:
		answer_4.text = AnswerString
		answerint = randnum
	answers = SaveData.save_dict[SaveData.set_selected][1].duplicate()
	question_number_text.text = str(questionumber) +"/" + str(numberofquestions)
	
func endtest():
	print("DONE")
	for child in get_children():
		child.visible = false
	var accuracy = numberofquestions/clicks * 100
	if accuracy <= 50:
		results.text = "Accuracy: " + str(round(accuracy)) + "%\nread the next question more carefully 💀💀"
	elif accuracy < 100:
		results.text = "Accuracy: " + str(round(accuracy)) + "%\nstand proud, you're strong."
	else:
		results.text = "Accuracy: " + str(round(accuracy)) + "%\nYou alone are the honored one"
	results.visible = true
	home_button.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(results, "theme_override_colors/font_color", Color(1,1,1,1) , 0.5 )
	


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

