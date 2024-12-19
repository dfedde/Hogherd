class_name Lines extends Node2D
@onready var line_manager := get_node("/root/LineManager")
@onready var current_line: Line2D = $CurrentLine
@onready var previous_line: Line2D = $PreviousLine
@export var points: PackedVector2Array

func _ready():
	previous_line.points = line_manager.get_line()
	current_line.points = points

func reset():
	line_manager.set_line(current_line.points)

func record_line():
	var point := get_global_mouse_position().snapped(Vector2.ONE)
	var current_points = current_line.points
	if current_points.is_empty() or (current_points[current_points.size()-1] - point).length() > 5:
		current_line.add_point(point)
	queue_redraw()
	return current_points

func length(line_points: Array[Vector2]):
	var distance: int = 0
	for i in line_points.size():
		if line_points.size() > i + 1:
			distance += line_points[i].distance_to(line_points[i+1])
	return distance
