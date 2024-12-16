class_name Lines extends Node2D
@onready var line_manager := get_node("/root/LineManager")
@onready var current_line: Line2D = $CurrentLine
@onready var previous_line: Line2D = $PreviousLine

func _ready():
	previous_line.points = line_manager.get_line()

func reset():
	line_manager.set_line(current_line.points)

func record_line():
	var point := get_global_mouse_position().snapped(Vector2.ONE)
	var current_points = current_line.points
	if current_points.is_empty() or (current_points[current_points.size()-1] - point).length() > 5:
		current_line.add_point(point)
	queue_redraw()
	return current_points

func length(aline: Array[Vector2]):
	var distance: int = 0
	for i in aline.size():
		if aline.size() > i + 1:
			distance += aline[i].distance_to(aline[i+1])
	return distance
