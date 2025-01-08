extends ProgressBar


func _process(delta: float) -> void:
	max_value = PigManager.max_energy
	value = PigManager.energy
