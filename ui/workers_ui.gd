extends TextureRect

onready var command_center : CommandCenter = $"../../../CommandCenter"
onready var supply_camp : SupplyCamp = $"../../../SupplyCamp"
onready var button_group : ButtonGroup = $Content/WorkerButtons.get_child(0).group

onready var worker_type_text : Label = $Content/WorkerType
onready var hired_text : Label = $Content/Hired
onready var hire_button : Button = $Content/Hired/Button



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
	hire_button.visible = supply_camp.can_sell("gold", 50)


func on_hire_button_pressed() -> void:
	var worker_type : String = button_group.get_pressed_button().name.to_lower()
	command_center.hire_worker(worker_type)	# TODO implement upgrades
	pass
