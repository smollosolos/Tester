extends Node
var datafile = "user://data.dat"
@onready var answersectionscene = preload("res://answer_section.tscn")
@onready var newsectionscene = preload("res://new_section.tscn")
@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var new_section: TextureButton = $ScrollContainer/VBoxContainer/NewSection
@onready var title: Label = $Title

var setname : String = ""
#idea copy set and import set
var numberofquestions : int = 1
var set : Array = [[],[]]

func _on_new_section_pressed() -> void:
	numberofquestions += 1
	new_section.queue_free()
	var answersection = answersectionscene.instantiate()
	var newsection = newsectionscene.instantiate()
	v_box_container.add_child(answersection)
	v_box_container.add_child(newsection)
	new_section = newsection
	newsection.connect("pressed", _on_new_section_pressed)
	answersection.get_node("Number").text = str(numberofquestions)
	answersection.get_node("trashset").connect("pressed", delete_set.bind(int(answersection.get_node("Number").text)))

func delete_set(set_number:int) -> void:
	for child in v_box_container.get_children():
		child.queue_free()
	SaveData.save_dict[SaveData.set_selected][0].remove_at(set_number-1)
	SaveData.save_dict[SaveData.set_selected][1].remove_at(set_number-1)
	setquestions()
	
func save() -> void:
	for i in v_box_container.get_child_count() - 1:
		set[0].append(v_box_container.get_child(i).get_node("Question").text)
		set[1].append(v_box_container.get_child(i).get_node("Answer").text)
	#"Answer"
	SaveData.save_dict[setname] = set
	var file = FileAccess.open(datafile, FileAccess.WRITE)
	file.store_var(SaveData.save_dict)
	set = [[],[]]

func _ready() -> void:
	if SaveData.set_selected == "":
		setname = SaveData.set_name
	else:
		$ScrollContainer/VBoxContainer/AnswerSection.queue_free()
		$ScrollContainer/VBoxContainer/NewSection.queue_free()
		setquestions()
		setname = SaveData.set_selected
	title.text = setname
	
func _on_save_button_pressed() -> void:
	save()


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_timer_timeout() -> void:
	save()

	
	
func setquestions():
	var questions = SaveData.save_dict[SaveData.set_selected][0]
	var answers = SaveData.save_dict[SaveData.set_selected][1]
	for i in SaveData.save_dict[SaveData.set_selected][0].size():
		var answersection = answersectionscene.instantiate()
		v_box_container.add_child(answersection)
		answersection.get_node("Question").text = questions[i]
		answersection.get_node("Answer").text = answers[i]
		answersection.get_node("Number").text = str(i+1)
		answersection.get_node("trashset").connect("pressed", delete_set.bind(int(answersection.get_node("Number").text)))
	var newsection = newsectionscene.instantiate()
	v_box_container.add_child(newsection)
	new_section = newsection
	newsection.connect("pressed", _on_new_section_pressed)
	numberofquestions = SaveData.save_dict[SaveData.set_selected][0].size()
	
func upload():
	pass
	
		
		
