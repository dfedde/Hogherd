extends CharacterBody2D
# Refactor:
# change flee target to the first item in the scary group.
# change flee target to a bool that starts the run.
# TODO: handle mutiple flee targets
@export var speed: int = 200
@export var max_dist: int = 150
const ANIMAL_TYPE := AnimalData.Type.WHITE_SHEEP

var start_position = Vector2()
var penned = false
var fleeing = false

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
		var flee_target = get_tree().get_first_node_in_group("Scary")
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
