class_name Pig extends CharacterBody2D

signal trace_compleate

@export var speed: int = 150
@export var curve_hold: int = 5
@export var energy: float = 100
@export var drain_factor: int = 10

var line = PackedVector2Array()
var line_index = 0
@onready var _last_position = position
	
func trace(line_):
	line = line_
	line_index = 0

func handle_line_following():
	if !line:
		return
	# if target is closer than curve_hold pixels away move 
	if position.distance_to(line[line_index]) < curve_hold: line_index += 1
	if position.snapped(Vector2.ONE) == _last_position.snapped(Vector2.ONE): line_index += 1
	if line_index >= line.size():
		line = null
		trace_compleate.emit()
		velocity = Vector2.ZERO
	else:
		velocity = Vector2(speed,0).rotated(position.angle_to_point(line[line_index]))
		rotation = velocity.angle()
		energy -= position.distance_to(_last_position)/drain_factor
		
func _physics_process(_delta):
	handle_line_following()
	_last_position = position
	move_and_slide()
