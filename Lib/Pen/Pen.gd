class_name Pen extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Penable"):
		meet_goal(body)
		body.in_pen()

func get_goals():
	print("get_goals")
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
		print(goal)
		if goal.met_by(animal):
			goal.met = true
			break
