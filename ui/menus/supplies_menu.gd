extends TextureRect

onready var supply_camp : SupplyCamp = $"../../../SupplyCamp"

onready var sell_one_button : Button = $Content/SellOne
onready var sell_ten_button : Button = $Content/SellTen

onready var button_group : ButtonGroup = $Content/ResourceList.get_child(0).group

func _ready() -> void:
	sell_one_button.connect("pressed", self, "on_sell_button_pressed", [1])
	sell_ten_button.connect("pressed", self, "on_sell_button_pressed", [10])
	
	button_group.get_buttons()[0].pressed = true
	

func _process(delta : float) -> void:
	update_supply_readings()
	update_sell_buttons()


func update_sell_buttons() -> void:
	var button_pressed : Button = button_group.get_pressed_button()
	var resource_name : String = button_pressed.name.to_lower()
	if resource_name == "gold":
		sell_one_button.visible = false
		sell_ten_button.visible = false
	else:
		sell_one_button.visible = true
		sell_ten_button.visible = true
		
		sell_one_button.icon = button_pressed.icon
		sell_ten_button.icon = button_pressed.icon
		
		var sell_value : int = supply_camp.sell_values[resource_name]
		sell_one_button.text = "Sell 1 (" + str(sell_value) + "G)"
		sell_ten_button.text = "Sell 10 (" + str(sell_value * 10) + "G)"
		
		sell_one_button.disabled = !supply_camp.has_resource(resource_name, 1)
		sell_ten_button.disabled = !supply_camp.has_resource(resource_name, 10)
	pass
		

func on_sell_button_pressed(sell_amount : int) -> void:
	var resource_sold : String = button_group.get_pressed_button().name.to_lower()
	supply_camp.sell(resource_sold, sell_amount)
	update_sell_buttons()


func update_supply_readings() -> void:
	for button in button_group.get_buttons():
		var resource_name : String = button.name.to_lower()
		button.text = get_supply_string(resource_name)


func get_supply_string(resource : String) -> String:
	var real_amount : int = supply_camp.get_real_amount(resource)
	var deficit : int = supply_camp.get_resource_deficit(resource)
	
	var output : String = str(real_amount)
	
	if deficit > 0:
		output += " (-" + str(deficit) + ")"
	
	return output
