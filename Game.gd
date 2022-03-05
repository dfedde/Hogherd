extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var line = PoolVector2Array()
var running = false
var ran = false
var previous_line = PoolVector2Array()
var started_line = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lines.set_previous_line(Global.get_line())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var pig = $Pig

	for sheep in sheeps():
		if running:
			sheep.run(pig.position)
		else:
			sheep.stop()
		

func _draw():
	if line.size() > 1:
		draw_polyline(line, Color(0.5, 0.5, 0.5), 3, true)
	if previous_line.size() > 1:
		draw_polyline(previous_line, Color(0.5, 0.5, 0.5, 0.5), 3, true)

func _input(_event):
	record_line()
		
	if Input.is_action_just_pressed("ui_cancel") and (running or ran):
		reset()
	
	if Input.is_action_just_pressed("down") and (running or ran):
		reset()

func run():
	running = true
		
	$Pig.trace(line)
	$Lines.set_previous_line(PoolVector2Array())
	
func reset():
	get_node("/root/Global").set_line(line)
	var _ok = get_tree().reload_current_scene()

func sheeps():
	return $Sheeps.get_children()
	
func record_line():
	# only allow drawing when the not running 
	if Input.is_action_pressed("down") and not (running or ran):
		started_line = true
		line.append( get_global_mouse_position() )
		$Lines.set_line(line)
		
	if Input.is_action_just_released("down") and started_line and not (running or ran):
		run()


func _on_Pig_trace_compleate():
	running = false
	ran = true


func _on_Pen_all_penned():
	print("all penned")
