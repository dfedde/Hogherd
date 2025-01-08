extends Button

func change_to_level():
	get_tree().change_scene_to_packed(LevelManager.current_level())

func _on_pressed() -> void:
	call_deferred("change_to_level")
