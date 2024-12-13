class_name PenGoal extends Node2D

@export var type: AnimalData.Type
@export var met: bool = false
@export var met_node: NodePath
@export var unmet_node: NodePath

func met_by(animal):
	if animal.ANIMAL_TYPE == type:
		return true
	else:
		return false
		
func _process(delta: float) -> void:
	#TODO: this sets the node to show or hide every frame it should be done only when met changes
	match met:
		true:
			get_node(met_node).show()
			get_node(unmet_node).hide()
		false:
			get_node(met_node).hide()
			get_node(unmet_node).show()
