class_name PenGoal extends Node2D

@export var type: AnimalData.Type
@export var met: bool

func met_by(animal):
	if animal.ANIMAL_TYPE == type:
		return true
	else:
		return false
	
