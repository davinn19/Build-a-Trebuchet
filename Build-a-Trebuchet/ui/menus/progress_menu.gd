extends Menu

onready var trebuchet : Trebuchet = $"../../../Trebuchet"
onready var num_stages : int = trebuchet.total_required_resources.size()

onready var button_group : ButtonGroup = $Content/ResourceList.get_child(0).group

onready var stage_text : Label = $Content/BuildStage
onready var progress : Label = $Content/BuildProgress

onready var resources : Array = $Content/ResourceList.get_children()


func _ready() -> void:
	pass
	
	
func _process(delta : float) -> void:
	update_appearance()


func update_appearance() -> void:
	stage_text.text = "Stage: " + str(trebuchet.build_stage + 1) + "/" + str(num_stages)
	progress.text = "Progress: (" + str(trebuchet.stage_work_done) + "/" + str(trebuchet.stage_work_required) + ")"
	
	var required_resources : Dictionary = trebuchet.cur_required_resources
	var resource_surplus : Dictionary = trebuchet.delivery_surplus
	
	for resource in resources:
		var resource_name : String = resource.name.to_lower()
		if !required_resources.has(resource_name):
			resource.visible = false
			continue
		
		resource.visible = true
		var amount_required : int = required_resources[resource_name]
		var surplus : int = resource_surplus[resource_name]
		
		var output : String = str(amount_required)
		if surplus > 0:
			output += " (-" + str(surplus) + ")"
		
		resource.text = output
