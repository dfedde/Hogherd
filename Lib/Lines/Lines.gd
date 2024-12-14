class_name Lines extends Node2D
@onready var line_manager := get_node("/root/LineManager")

func _ready():
	previous_line = line_manager.get_line()
	
var line = PackedVector2Array(): 
	set(new_value):
		line = new_value
		queue_redraw()
		
var previous_line = PackedVector2Array():
	set(new_value):
		previous_line = new_value
		queue_redraw()
		
func reset():
	line_manager.set_line(line)
	
func _draw():
	if line.size() > 1:
		draw_polyline(line, Color(1, 0.5, 0.5), 3, true)
	if previous_line.size() > 1:
		draw_polyline(previous_line, Color(0.5, 0.5, 1, 0.5), 3, true)
	print(length(line)/12)
		
func record_line():
	var point := get_global_mouse_position().snapped(Vector2.ONE)
	if line.is_empty() or (line[line.size()-1] - point).length() > 5:
		line.append(point)
	queue_redraw()
	return line

func length(aline: Array[Vector2]):
	var distance: int = 0
	for i in aline.size():
		if aline.size() > i + 1:
			distance += aline[i].distance_to(aline[i+1])
	return distance
