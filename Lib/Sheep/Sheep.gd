extends CharacterBody2D

@export var speed: int = 200
@export var max_dist: int = 150
@export var debug: bool = true
const ANIMAL_TYPE := AnimalData.Type.WHITE_SHEEP

var start_position = Vector2()
var penned = false
var fleeing = false
var _rays: Array[Direction] 

func _ready():
	start_position = position

func run():
	fleeing = true
	
func stop():
	velocity = Vector2()

func in_pen():
	penned = true
	queue_free()

func _physics_process(_delta):
	if fleeing:
		_rays = []
		var sum = Vector2.ZERO
		for scary in get_tree().get_nodes_in_group("Scary"):
			var dir := Direction.new(position.angle_to_point(scary.position))
			dir.danger = inverse_lerp(max_dist, 0, min(position.distance_to(scary.position), max_dist))
			_rays.append(dir)
		for ray in _rays:	
			sum += Vector2(ray.score(),0).rotated(ray.angle)
		velocity = sum.normalized() * speed
	$AnimatedSprite2D.set_motion(velocity)
	move_and_slide()
	queue_redraw()

func _draw() -> void:
	if debug:
		for ray in _rays:
			draw_line(Vector2.ZERO, Vector2(abs(ray.score() * 100), 0).rotated(ray.angle), Color.RED if ray.score() < 0 else Color.GREEN, 2)
		
class Direction:
	var angle: float
	var intrest: float
	var danger: float
	
	func _init(_angle: float) -> void:
		angle = _angle
	
	func score() -> float:
		return intrest - danger
		
	func _to_string() -> String:
		return "{angle: %f, intrest: %f, danger: %f }" % [angle, intrest, danger]
