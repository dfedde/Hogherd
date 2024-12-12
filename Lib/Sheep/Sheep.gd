extends CharacterBody2D

@export var speed: int = 200
@export var max_dist: int = 300
const ANIMAL_TYPE := AnimalData.Type.WHITE_SHEEP

var start_position = Vector2()
var penned = false
var flee_target: Pig

func _ready():
	start_position = position

func run(from):
	flee_target = from
	
func stop():
	velocity = Vector2()

func in_pen():
	penned = true
	queue_free()

func _physics_process(_delta):
	if flee_target:
		velocity = Vector2(-speed_with_falloff(flee_target.position),0).rotated(position.angle_to_point(flee_target.position))
	$AnimatedSprite2D.set_motion(velocity)
	move_and_slide()

# speed is faster when the target is closer
func speed_with_falloff(target):
	var dist = target.distance_to(position)
	if dist > max_dist:
		return 0
	else:
		return sqrt(-dist*speed+(max_dist*speed))
