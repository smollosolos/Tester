extends Node

@onready var question_number_text: Label = $"question number"
@onready var question: TextEdit = $question
@onready var answer: TextEdit = $Answer
@onready var result: Label = $result
@onready var results: Label = $results
@onready var home_button: TextureButton = $"home button"

var questionumber : int = 1
var questions : Array = []
var numberofquestions : int = 0
var answers : Array = []
var orgquestions : Array = []
var clicks : float = 0

func _ready() -> void:
	randomize()
	questions = SaveData.save_dict[SaveData.set_selected][0].duplicate()
	answers = SaveData.save_dict[SaveData.set_selected][1].duplicate()
	orgquestions = SaveData.save_dict[SaveData.set_selected][0].duplicate()
	numberofquestions = orgquestions.size()
	next_question()
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if answer.has_focus():
			clicks+=1
			answer_set()
			get_viewport().set_input_as_handled()
	

func next_question():
	if questions.size() > 0:
		question.text = questions.pick_random()
		questions.erase(question.text)
		question_number_text.text = str(questionumber) +"/" + str(numberofquestions)
	else:
		endtest()

func answer_set() -> void:
	result.visible = true
	if answer.text.to_lower() == answers[orgquestions.find(question.text)].to_lower():
		questionumber+=1
		next_question()
		answer.text = ""
		result.text = "correct"
		var tween = get_tree().create_tween()
		tween.tween_property(result, "modulate", Color(0,0.54,0.15,1) , 0.5 )
		await get_tree().create_timer(1).timeout
		var tween2 = get_tree().create_tween()
		tween2.tween_property(result, "modulate", Color(0,0,0,1) , 0.5 )
		await tween2.finished
		result.visible = false
	else:
		result.text = "incorrect"
		answer.set_caret_column(answer.text.length())
		var tween = get_tree().create_tween()
		tween.tween_property(result, "modulate", Color(0.68,0.04,0.04,1) , 0.5 )
		await get_tree().create_timer(1).timeout
		var tween2 = get_tree().create_tween()
		tween2.tween_property(result, "modulate", Color(0,0,0,1) , 0.5 )
		await tween2.finished
		result.visible = false
		
func endtest() -> void:
	for child in get_children():
		child.visible = false
	var accuracy = float(numberofquestions)/clicks * 100
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



func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
