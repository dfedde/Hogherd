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
		PLAYING when event.is_action_pressed("ui_cancel") or event.is_action_pressed("down"):
			reset()
		DONE when event.is_action_pressed("ui_cancel") or event.is_action_pressed("down"):
			reset()

func _process(_delta: float) -> void:
	if STATE == DRAWING:
		line = lines.record_line()
		
func run():
	STATE = PLAYING
	for sheep in sheeps():
		sheep.run($Pig)
	$Pig.trace(line)
	
func reset():
	lines.reset()
	var _ok = get_tree().reload_current_scene()

func sheeps():
	return $Herd.get_children()

func _on_Pig_trace_compleate():
	STATE = DONE
	
func all_pens_filled():
	var filled = true
	for pen in pens:
		filled = pen.goals_met() and filled
	return filled
	
func change_to_next_level():
	get_tree().change_scene_to_packed(LevelManager.next_level())
	
func _on_pen_all_penned() -> void:
	if all_pens_filled():
		call_deferred("change_to_next_level")
	
