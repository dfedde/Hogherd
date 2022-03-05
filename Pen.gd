extends Area2D


signal all_penned
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var penned_sheep = []

	
func _physics_process(_delta):
	for body in get_overlapping_bodies():
		if body.get_parent().name == "Sheeps":
			if penned_sheep.find(body) == -1:
				penned_sheep.append(body)
				body.in_pen()
	if penned_sheep.size() == 2:
		emit_signal("all_penned")
