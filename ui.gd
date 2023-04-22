extends Control

onready var cam : Camera2D = $"../../Cam"

var in_transition : bool = false

func open_ui(ui_name : String) -> void:
	# TODO implement
	var selected_ui : Control = get_node(ui_name)

	for window in get_children():
		if window.name != ui_name:
			window.visible = false
		else:
			window.visible = !window.visible

