extends Node2D

var line = PackedVector2Array()
var running = false
var ran = false
var previous_line = PackedVector2Array()
var started_line = false
@onready var lines: Lines = $Lines
@onready var line_manager := get_node("/root/LineManager")
func _ready():
	previous_line = line_manager.get_line()

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
	line_manager.set_line(line)
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
	lines.line= line
	lines.previous_line = previous_line

func _on_Pig_trace_compleate():
	running = false
	ran = true

func _on_Pen_all_penned():
	print("all penned")
