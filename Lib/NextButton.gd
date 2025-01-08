extends Button

func change_to_next_level():
	get_tree().change_scene_to_packed(LevelManager.next_level())
	
func _on_pressed() -> void:
	call_deferred("change_to_next_level")
