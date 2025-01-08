extends Node

@export var max_energy: int = 100
@export var energy: float
@export var money: int
const LEVEL_OVER_OVERLAY = preload("res://Lib/LevelOverOverlay.tscn")

func _ready() -> void:
	reset()
	
func reset():
	energy = max_energy
	
func register(pig: Pig) -> void:
	pig.connect("out_of_energy", _on_pig_out_of_energy)
	pig.connect("trace_compleate", _on_trace_compleate)
	
func _on_pig_out_of_energy() -> void:
	reset()
	get_tree().change_scene_to_packed(LevelManager.shop())

func _on_trace_compleate() -> void:
	get_tree().get_current_scene().add_child(LEVEL_OVER_OVERLAY.instantiate())
