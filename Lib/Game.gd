extends Node2D

var line = PackedVector2Array()
var running = false
var ran = false
var started_line = false
@onready var lines: Lines = $Lines
@onready var line_manager := get_node("/root/LineManager")

func _ready():
	lines.previous_line = line_manager.get_line()

func _input(_event):
	#TODO: This could be refactered with a statemachine
	if not (running or ran) and Input.is_action_pressed("down"):
		line = lines.record_line()
	elif not (running or ran) and Input.is_action_just_released("down") and not line.is_empty():
		run()
	elif Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("down"):
		reset()

func run():
	running = true
	for sheep in sheeps():
		sheep.run($Pig)
	$Pig.trace(line)
	
func reset():
	print("reset called")
	line_manager.set_line(line)
	var _ok = get_tree().reload_current_scene()

func sheeps():
	return $Herd.get_children()

func _on_Pig_trace_compleate():
	running = false
	ran = true

func _on_Pen_all_penned():
	print("all penned")
