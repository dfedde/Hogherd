class_name Pig extends CharacterBody2D

signal trace_compleate
signal out_of_energy

@export var speed: int = 150
@export var curve_hold: int = 5
@export var energy: float = 100
@export var drain_factor: int = 10

var following := false

var line = PackedVector2Array()
var line_index = 0
@onready var _last_position = position

func _ready() -> void:
	PigManager.register(self)
	energy = PigManager.energy

func trace(line_):
	following = true
	line = line_
	line_index = 0
	
func stop():
		following = false
		velocity = Vector2.ZERO
		
func handle_line_following():
	if !following:
		return
	# if target is closer than curve_hold pixels away move 
	if position.distance_to(line[line_index]) < curve_hold: line_index += 1
	if position.snapped(Vector2.ONE) == _last_position.snapped(Vector2.ONE): line_index += 1
	if line_index >= line.size():
		stop()
		trace_compleate.emit()
	else:
		velocity = Vector2(speed,0).rotated(position.angle_to_point(line[line_index]))
		rotation = velocity.angle()
		energy -= position.distance_to(_last_position)/drain_factor
		PigManager.energy = energy

		
func _physics_process(_delta):
	if energy <= 0:
		stop()
		out_of_energy.emit()
	handle_line_following()
	_last_position = position
	move_and_slide()
