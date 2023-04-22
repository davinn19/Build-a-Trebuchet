class_name WorkPosBounds
extends Node2D


onready var bot_right : Vector2 = $BotRight.global_position


func get_random_pos() -> Vector2:
	var x : int = rand_range(global_position.x, bot_right.x)
	var y : int = rand_range(bot_right.y, global_position.y)
	
	return Vector2(x, y)
