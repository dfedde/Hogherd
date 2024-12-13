class_name PenGoal extends Node2D

@export var type: AnimalData.Type
@export var met: bool = false: 
	set(new_value):
		met = new_value
		change = true
		
@export var met_node: NodePath
@export var unmet_node: NodePath
var change = true

func met_by(animal):
	if animal.ANIMAL_TYPE == type:
		return true
	else:
		return false
		
func _process(delta: float) -> void:
	if change:
		match met:
			true:
				get_node(met_node).show()
				get_node(unmet_node).hide()
			false:
				get_node(met_node).hide()
				get_node(unmet_node).show()
	change = false
