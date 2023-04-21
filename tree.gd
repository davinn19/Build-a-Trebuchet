class_name TreeResource
extends Node2D

signal tree_felled

onready var tween : Tween = $Tween
onready var tree_sprite : Sprite = $TreeSprite

var chops_left : int = 20


func chop() -> void:
	if !has_chops():
		return
	
	chops_left -= 1
	if !has_chops():
		emit_signal("tree_felled")
		fall_over()


func fall_over() -> void:
	tween.interpolate_property(tree_sprite, "rotation_degrees", 0, 90, 5, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	pass


func has_chops() -> bool:
	return chops_left > 0
