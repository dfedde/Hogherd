extends Area2D

var penned_sheep = []

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Penable"):
		penned_sheep.append(body)
		body.in_pen()