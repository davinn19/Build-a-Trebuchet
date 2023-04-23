class_name Game
extends Node

signal transition_done

const field_template : PackedScene = preload("res://field.tscn")
const covered : Color = Color(0, 0, 0, 1)
const uncovered : Color = Color(0, 0, 0 ,0)

onready var transition_panel : ColorRect = $Transition/ColorRect
onready var tween : Tween = $Transition/ColorRect/Tween


var cur_field : Field

func _ready():
	load_field()


func load_field() -> void:
	cur_field = field_template.instance()
	add_child(cur_field)
	cur_field.connect("game_ended", self, "on_field_done")
	transition_in()


func transition_in() -> void:
	tween.interpolate_property(transition_panel, "color", covered, uncovered, 2)
	tween.start()
	get_tree().paused = false


func transition_out() -> void:
	tween.interpolate_property(transition_panel, "color", uncovered, covered, 2)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("transition_done")


func on_field_done() -> void:
	transition_out()
	yield(self, "transition_done")
	get_tree().paused = true
	cur_field.queue_free()
	load_field()
