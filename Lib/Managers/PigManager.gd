extends Node

@export var max_energy: int = 100
@export var energy: float

func _ready() -> void:
	reset()
	
func reset():
	energy = max_energy
	
func register(pig: Pig) -> void:
	pig.connect("out_of_energy", _on_pig_out_of_energy)
	
func _on_pig_out_of_energy() -> void:
	reset()
	get_tree().change_scene_to_packed(LevelManager.shop())
