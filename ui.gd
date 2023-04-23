extends Control

onready var cam : Camera2D = $"../../Cam"
onready var menus : Array = get_children()

var in_transition : bool = false


func _ready() -> void:
	for menu in menus:
		menu.visible = false


func open_ui(ui_name : String) -> void:
	var selected_menu : Menu = get_node(ui_name)

	for menu in menus:
		if menu != selected_menu:
			menu.close()
			continue

		if menu.visible:
			menu.close()
		else:
			menu.open()

