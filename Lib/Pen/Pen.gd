class_name Pen extends Area2D

signal all_penned
#TODO: we don't need to re get goals every check it could be handled in _ready
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Penable"):
		meet_goal(body)
		body.in_pen()
		print(get_unmet_goals())
		if get_unmet_goals().size() == 0:
			all_penned.emit()

func get_goals():
	var childgoals: Array[PenGoal]
	for child in get_children():
		if child is PenGoal:
			childgoals.append(child)
	return childgoals


func get_unmet_goals():
	var goals: Array[PenGoal]
	for goal in get_goals():
		if not goal.met:
			goals.append(goal)
	return goals

func meet_goal(animal):
	for goal in get_unmet_goals():
		if goal.met_by(animal):
			goal.met = true
			break
