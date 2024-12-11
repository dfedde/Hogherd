class_name Lines extends Node2D

var line = PackedVector2Array(): 
	set(new_value):
		line = new_value
		queue_redraw()
		
var previous_line = PackedVector2Array():
	set(new_value):
		previous_line = new_value
		queue_redraw()
	
func _draw():
	if not line.is_empty():
		draw_polyline(line, Color(1, 0.5, 0.5), 3, true)
	if not previous_line.is_empty():
		draw_polyline(previous_line, Color(1, 0.5, 0.5, 0.5), 3, true)
		
func record_line():
	line.append(get_global_mouse_position().snapped(Vector2.ONE))
	queue_redraw()
	return line
