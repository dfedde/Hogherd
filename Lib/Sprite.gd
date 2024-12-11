extends AnimatedSprite2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()
@export var start_animation: String = "RIGHT"
var sprites = {
	"DOWN": motion.angle_to(Vector2.UP),
	"UP": motion.angle_to(Vector2.DOWN),
	"RIGHT": motion.angle_to(Vector2.LEFT),
	"LEFT": motion.angle_to(Vector2.RIGHT)
	}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_motion(motion_):
	motion = motion_

func _process(_delta):
	var playing = true
	var lowest_key = start_animation
	var lowest = sprites[lowest_key]
	for key in sprites:
		if sprites[key] > lowest:
			lowest_key =  key
			lowest = sprites[key]
	animation = lowest_key
	
