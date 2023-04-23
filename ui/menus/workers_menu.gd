extends TextureRect

onready var command_center : CommandCenter = $"../../../CommandCenter"
onready var supply_camp : SupplyCamp = $"../../../SupplyCamp"
onready var button_group : ButtonGroup = $Content/WorkerButtons.get_child(0).group

onready var worker_type_text : Label = $Content/WorkerType
onready var hired_text : Label = $Content/Hired
onready var hire_button : Button = $Content/Hired/Button
onready var upgrades : Array = $Content/Upgrades.get_children()


func _ready() -> void:
	button_group.get_buttons()[0].pressed = true
	
	hire_button.connect("pressed", self, "on_hire_button_pressed")
	pass


func _process(delta : float) -> void:
	update_appearance()
	pass


func update_appearance() -> void:
	var pressed_button : Button = button_group.get_pressed_button()
	
	var worker_type : String = pressed_button.name.to_lower()
	worker_type_text.text = worker_type
	
	var num_hired : int = command_center.num_workers[worker_type]
	hired_text.text = "Hired: " + str(num_hired)
	hire_button.disabled = !supply_camp.has_resource("gold", command_center.hire_cost)
	
	for upgrade in upgrades:
		var upgrade_name = upgrade.name.to_lower()
		var upgrade_level : int = command_center.get_upgrade_level(worker_type, upgrade_name)
		upgrade.text = upgrade.name + ": " + str(upgrade_level)
		
		var upgrade_button : Button = upgrade.get_node("Button")
		var upgrade_cost : int = command_center.get_upgrade_cost(worker_type, upgrade_name)
		upgrade_button.text = "+1 (" + str(upgrade_cost) + "g)"
		upgrade_button.disabled = !supply_camp.has_resource("gold", upgrade_cost)


func on_hire_button_pressed() -> void:
	var worker_type : String = button_group.get_pressed_button().name.to_lower()
	command_center.hire_worker(worker_type)	# TODO implement upgrades
	pass
