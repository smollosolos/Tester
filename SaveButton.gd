extends TextureButton

var currentscale : float
var currentposition : Vector2


func _ready() -> void:
	currentposition = position
	currentscale = scale.x

func _on_mouse_entered() -> void:
	modulate = "2e2e2e"
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(currentscale+0.02,currentscale+0.02) , 0.2 )
	tween2.tween_property(self, "position", Vector2(currentposition.x-4,currentposition.y-6) , 0.2 )


func _on_mouse_exited() -> void:
	modulate = "ffffff"
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(currentscale,currentscale) , 0.2 )
	tween2.tween_property(self, "position", currentposition , 0.2 )
