extends Control

onready var cam : Camera2D = $"../../Cam"
onready var menus : Array = get_children()

var in_transition : bool = false


func _ready() -> void:
	for menu in menus:
		menu.visible = false


func open_ui(ui_name : String) -> void:
	# TODO implement
	var selected_ui : Control = get_node(ui_name)

	for menu in menus:
		if menu.name != ui_name:
			menu.visible = false
		else:
			menu.visible = !menu.visible

