extends Node2D
enum {START, DRAWING, PLAYING, DONE}
var STATE = START
var line = PackedVector2Array()
@onready var lines: Lines = $Lines

func _input(event):
	match STATE:
		START when event.is_action_pressed("down"):
			STATE = DRAWING
		DRAWING when event.is_action_released("down"):
			run()
		PLAYING when event.is_action_pressed("ui_cancel") or Input.is_action_pressed("down"):
			reset()
		DONE when event.is_action_pressed("ui_cancel") or Input.is_action_pressed("down"):
			reset()

func _process(delta: float) -> void:
	if STATE == DRAWING:
		line = lines.record_line()
		
func run():
	STATE = PLAYING
	for sheep in sheeps():
		sheep.run($Pig)
	$Pig.trace(line)
	
func reset():
	print("reset called")
	lines.reset()
	var _ok = get_tree().reload_current_scene()

func sheeps():
	return $Herd.get_children()

func _on_Pig_trace_compleate():
	STATE = DONE

func _on_Pen_all_penned():
	print("all penned")
