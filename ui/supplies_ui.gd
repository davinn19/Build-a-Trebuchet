class_name SuppliesUI
extends TextureRect

onready var supply_camp : SupplyCamp = $"../../../SupplyCamp"

var is_open : bool = false

var selected_resource : String

onready var resources : Array = $Content/ResourceList.get_children()

func _ready() -> void:
	on_resource_click(resources[0])
	
	for resource in resources:
		resource.connect("pressed", self, "on_resource_click", [resource])


func _process(delta : float) -> void:
	update_supply_readings()


func update_supply_readings() -> void:
	for resource in resources:
		var resource_name : String = resource.name.to_lower()
		resource.get_node("Amount").text = get_supply_string(resource_name)


func on_resource_click(resource_clicked : Control) -> void:
	var resource_clicked_name : String = resource_clicked.name
	selected_resource = resource_clicked_name
	update_selection_colors()
	
	
func update_selection_colors() -> void:
	for resource in resources:
		var amount_label : Label = resource.get_node("Amount")
		if resource.name == selected_resource:
			amount_label.add_color_override("font_color", Color(171690))
		else:
			amount_label.remove_color_override("font_color")
	pass
	
	
func get_supply_string(resource : String) -> String:
	var real_amount : int = supply_camp.get_real_amount(resource)
	var deficit : int = supply_camp.get_resource_deficit(resource)
	
	var output : String = str(real_amount)
	
	if deficit > 0:
		output += " (-" + str(deficit) + ")"
	
	return output
