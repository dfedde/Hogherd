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
		for scary in get_tree().get_nodes_in_group("Scary"):
			var dir := Direction.new(position.angle_to_point(scary.position))
			dir.danger = position.distance_to(scary.position)
			_rays.append(dir)
			print(dir)
			# TODO: this only handles fleeying from the last one may need context steering
			velocity = Vector2(-speed_with_falloff(scary.position),0).rotated(position.angle_to_point(scary.position))
	$AnimatedSprite2D.set_motion(velocity)
	move_and_slide()
	queue_redraw()

func _draw() -> void:
	if debug:
		for ray in _rays:
			draw_line(Vector2.ZERO, Vector2(abs(ray.score()), 0).rotated(ray.angle), Color.RED if ray.score() < 0 else Color.GREEN, 2)
		
# speed is faster when the target is closer
func speed_with_falloff(target):
	var dist = target.distance_to(position)
	if dist > max_dist:
		return 0
	else:
		return sqrt(-dist*speed+(max_dist*speed))
		
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
