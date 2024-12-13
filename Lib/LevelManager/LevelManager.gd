extends Node

var levels := [
	"res://Levels/Level_1.tscn",
	"res://Levels/Level_2.tscn",
	"res://Levels/Win.tscn"
]
var current_level_index := 0

func current_level():
	return load(levels[current_level_index])

func next_level():
	current_level_index += 1
	return current_level()
