extends KinematicBody2D

export (int) var speed = 200
export (int) var max_dist = 300

var velocity = Vector2()
var start_position =  Vector2()
var penned = false

func _ready():
	start_position = position

func run(from):
	if penned:
		return
	velocity = Vector2(-speed_with_falloff(from),0).rotated(from.angle_to_point(position))
	
func stop():
	velocity = Vector2()

func in_pen():
	penned = true
	stop()

func _physics_process(_delta):
	$AnimatedSprite.set_motion(velocity)
	velocity = move_and_slide(velocity)

# speed is faster when the target is closer
func speed_with_falloff(target):
	var dist = target.distance_to(position)
	if dist > max_dist:
		return 0
	else:
		return sqrt(-dist*speed+(max_dist*speed))

