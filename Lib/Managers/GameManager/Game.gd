class_name GameManager extends Node2D
enum {START, DRAWING, PLAYING, DONE}
var STATE = START
var line = PackedVector2Array()
var pens : Array[Pen]
@onready var lines: Lines = $Lines

func register_pen(pen):
	pens.append(pen)
	
func _input(event):
	match STATE:
		START when event.is_action_pressed("down"):
			STATE = DRAWING
		DRAWING when event.is_action_released("down"):
			run()

func _process(_delta: float) -> void:
	if STATE == DRAWING:
		line = lines.record_line()
		
func run():
	STATE = PLAYING
	get_tree().call_group("Penable", "run")
	$Pig.trace(line)

func reset():
	lines.reset()
	var _ok = get_tree().reload_current_scene()
	
func all_pens_filled():
	var filled = true
	for pen in pens:
		filled = pen.goals_met() and filled
	return filled
		
