class_name Menu
extends Control


func open() -> void:
	visible = true
	set_process(true)
	pass


func close() -> void:
	visible = false
	set_process(false)
	pass
