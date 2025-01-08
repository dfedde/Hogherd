extends Node

@export var max_energy: int = 100
@export var energy: float

func _ready() -> void:
	reset()
	
func reset():
	energy = max_energy
	
