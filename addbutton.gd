extends TextureButton

func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.9,0.9) , 0.2 )
	tween2.tween_property(self, "position", Vector2(1765,17) , 0.2 )


func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.7,0.7), 0.2 )
	tween2.tween_property(self, "position", Vector2(1781,30) , 0.2 )
