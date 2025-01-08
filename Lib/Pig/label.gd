extends Label
@onready var pig: Pig = $".."

func _process(_delta: float) -> void:
	text = "%.0f" % [pig.energy]
