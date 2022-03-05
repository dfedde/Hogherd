extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()
export (String) var start_animation = "RIGHT"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_motion(motion_):
	motion = motion_

func _process(delta):
	if motion == Vector2():
		playing = false
	else:
		playing = true
	var sprites = {
	"DOWN": motion.angle_to(Vector2.UP),
	"UP": motion.angle_to(Vector2.DOWN),
	"RIGHT": motion.angle_to(Vector2.LEFT),
	"LEFT": motion.angle_to(Vector2.RIGHT)
	}
	var lowest_key = start_animation
	var lowest = sprites[lowest_key]
	for key in sprites:
		if sprites[key] > lowest:
			lowest_key =  key
			lowest = sprites[key]
	animation = lowest_key
#	print("UP: " + String(motion.angle_to(Vector2.UP)))
#	print("DOWN: " + String(motion.angle_to(Vector2.DOWN)))
#	print("LEFT: " + String(motion.angle_to(Vector2.LEFT)))
#	print("RIGHT: " + String(motion.angle_to(Vector2.RIGHT)))
	
