extends KinematicBody2D


signal trace_compleate

export (int) var speed = 250
export (int) var curve_hold = 5

var velocity = Vector2()
var line = PoolVector2Array()
var line_index = 0
var start_position =  Vector2()

func _ready():
	start_position = position
	
func trace(line_):
	line = line_
	line_index = 0

func _physics_process(_delta):
	$Sprite.set_motion(velocity)
	if !line:
		return
	var target = line[line_index]
	if position.distance_to(target) < curve_hold:
		line_index = line_index + 1
		if line_index >= line.size():
			line = null
			velocity = Vector2()
			emit_signal("trace_compleate")
			return
		target = line[line_index]
	velocity = 	Vector2(speed,0).rotated(target.angle_to_point(position))
	velocity = move_and_slide(velocity)
