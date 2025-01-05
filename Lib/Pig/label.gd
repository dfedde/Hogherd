extends Label
@onready var pig: Pig = $".."

func _process(delta: float) -> void:
	text = "%.0f" % [pig.energy]
