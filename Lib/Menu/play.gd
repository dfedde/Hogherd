extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(LevelManager.current_level())
