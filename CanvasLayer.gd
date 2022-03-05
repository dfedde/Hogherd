extends Node2D


# Declare member variables here. Examples:
# var a = 2
var line = PoolVector2Array()
var previous_line = PoolVector2Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_line(line_):
	line = line_
	update()

func set_previous_line(previous_line_):
	previous_line = previous_line_
	update()
	
func _draw():
	if line.size() > 1:
		draw_polyline(line, Color(0.5, 0.5, 0.5), 3, true)
	if previous_line.size() > 1:
		draw_polyline(previous_line, Color(0.5, 0.5, 0.5, 0.5), 3, true)
