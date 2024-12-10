extends Node2D

var line = PackedVector2Array()
var running = false
var ran = false
var previous_line = PackedVector2Array()
var started_line = false


func _ready():
	previous_line = get_node("/root/Global").get_line()

func _draw():
	if line.size() > 1:
		draw_polyline(line, Color(1, 0.5, 0.5), 3, true)
	if previous_line.size() > 1:
		draw_polyline(previous_line, Color(0.5, 0.5, 0.5, 0.5), 3, true)

func _input(_event):
	if not (running or ran):
		record_line()
	elif Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("down"):
		reset()

func run():
	running = true
	for sheep in sheeps():
		sheep.run($Pig)
	$Pig.trace(line)
	
func reset():
	get_node("/root/Global").set_line(line)
	var _ok = get_tree().reload_current_scene()

func sheeps():
	return $Herd.get_children()
	
func record_line():
	# only allow drawing when the not running 
	if Input.is_action_pressed("down"):
		started_line = true
		line.append( get_global_mouse_position().snapped(Vector2.ONE))
		queue_redraw()
		
	if Input.is_action_just_released("down") and started_line:
		run()

func _on_Pig_trace_compleate():
	running = false
	ran = true

func _on_Pen_all_penned():
	print("all penned")
