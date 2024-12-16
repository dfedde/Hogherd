class_name Pig extends CharacterBody2D

signal trace_compleate

@export var speed: int = 150
@export var curve_hold: int = 5

var line = PackedVector2Array()
var line_index = 0
var start_position =  Vector2()

func _ready():
	start_position = position
	
func trace(line_):
	line = line_
	line_index = 0

func _physics_process(_delta):
	$Sprite2D.set_motion(velocity)
	if !line:
		return
	var target = line[line_index]
	if position.distance_to(target) < curve_hold:
		line_index = line_index + 1
		if line_index >= line.size():
			line = null
			emit_signal("trace_compleate")
			return
		target = line[line_index]
	velocity = Vector2(speed,0).rotated(position.angle_to_point(target))
	move_and_slide()
