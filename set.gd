extends TextureRect
@onready var control: Control = $playbutton/Control

@onready var current_clipboard = DisplayServer.clipboard_get()
@onready var copylabel: Label = $copyButton/Label
var datafile = "user://data.dat"

#add edit mode fix garbage and add delteable questons also add optin to upload

func _ready() -> void:
	control.visible = false
	
func _on_texture_button_pressed() -> void:
	#COPY
	DisplayServer.clipboard_set(str(SaveData.save_dict[$setname.text]))
	copylabel.visible = true
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(copylabel, "theme_override_colors/font_color", Color(0.68,0.51,0,0) , 0.5 )
	await tween.finished
	copylabel.visible = false
	copylabel["theme_override_colors/font_color"] = Color(0.68,0.51,0,1)


func _on_delete_button_pressed() -> void:
	SaveData.save_dict.erase($setname.text)
	save()
	queue_free()
	

func save() -> void:
	var file = FileAccess.open(datafile, FileAccess.WRITE)
	file.store_var(SaveData.save_dict)


func _on_playbutton_pressed() -> void:
	control.visible = !control.visible



func _on_editbutton_pressed() -> void:
	SaveData.set_selected = $setname.text
	get_tree().change_scene_to_file("res://create.tscn")


func _on_multiplechoicebutton_pressed() -> void:
	SaveData.set_selected = $setname.text
	get_tree().change_scene_to_file("res://play_1.tscn")


func _on_openansswerbutton_2_pressed() -> void:
	SaveData.set_selected = $setname.text
	get_tree().change_scene_to_file("res://play_2.tscn")

