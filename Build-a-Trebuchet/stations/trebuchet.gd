class_name Trebuchet
extends Station

signal build_completed

export var arm_joints_active = false

var total_required_resources : Array = [
	{
		"stone" : 20
	},
	{
		"wood" : 25,
	},
	{
		"wood" : 30,
		"fibers" : 5
	},
	{
		"wood" : 40,
		"fibers" : 10
	},
	{
		"wood" : 50,
		"iron" : 5
	},
	{
		"wood" : 50,
		"iron" : 5,
		"fibers" : 20
	},
	{
		"wood" : 75,
	},
	{
		"wood" : 50,
		"fibers" : 20,
		"iron" : 10,
	},
	{
		"wood" : 30,
		"iron" : 25,
		"stone" : 50
	},
	{
		"wood" : 120,
	},
	{
		"fibers" : 50,
	},
	{
		"fibers" : 40,
		"iron" : 40
	},
	{
		"stone" : 100,
		"iron" : 50
	}
]

var build_stage : int = -1
var cur_required_resources : Dictionary
var pending_work : int = 0
var stage_work_done : int = 0
var stage_work_required : int = 0

var delivery_queue : Dictionary = {}

var delivery_surplus : Dictionary = Resources.get_resource_dictionary()

onready var anim : AnimationPlayer = $Anim
onready var work_pos_bounds : WorkPosBounds = $WorkPosBounds

onready var counterweight : Node2D = $Parts/Counterweight
onready var sling : Node2D = $Parts/Arm/Sling
onready var counterweight_joint : Node2D = $Parts/Arm/CounterweigtJoint


func _ready() -> void:
	anim.play("BuildAnimation", -1, 0)
	build_stage = -1
	goto_next_stage()


func _process(delta : float) -> void:
	if arm_joints_active:
		counterweight.global_position = counterweight_joint.global_position
		counterweight.global_rotation = 0


func work(worker_inventory : Inventory, skill_level : int) -> void:
	var work_done : int = randi() % (skill_level + 2)
	pending_work = max(pending_work - work_done, 0)
	stage_work_done = min(stage_work_done + work_done, stage_work_required)
	if is_build_stage_complete():
		goto_next_stage()


func get_work_pos() -> Vector2:
	return work_pos_bounds.get_random_pos()


func is_build_stage_complete() -> bool:
	return stage_work_done >= stage_work_required


func goto_next_stage() -> void:
	build_stage += 1
	update_appearance()
	if build_stage >= total_required_resources.size():
		emit_signal("build_completed")
	else:
		cur_required_resources = total_required_resources[build_stage].duplicate()

		stage_work_done = 0
		stage_work_required = 0
		for resource_amount in cur_required_resources.values():
			stage_work_required += resource_amount
	pass


func update_appearance() -> void:
	var keyframe_time : float = 0.1 * build_stage
	anim.seek(keyframe_time)


func get_required_resources() -> Dictionary:
	var required_resources : Dictionary = cur_required_resources.duplicate()
	for resource in required_resources:
		required_resources[resource] -= delivery_surplus[resource]
	
	return required_resources


func queue_delivery(worker_inventory : Inventory, delivery_list : Dictionary) -> void:
	assert(!delivery_queue.has(worker_inventory))
	delivery_queue[worker_inventory] = delivery_list
	
	for resource in delivery_list:
		delivery_surplus[resource] += delivery_list[resource]

	pass	# TODO combine with supply camp???


func do_delivery(worker_inventory : Inventory) -> void:
	var delivery_list : Dictionary = delivery_queue[worker_inventory]
	for resource in delivery_list:
		var delivered_amount : int = delivery_list[resource]
		worker_inventory.take_resource(resource, delivered_amount)
		
		if !cur_required_resources.has(resource):
			continue
		
		cur_required_resources[resource] -= delivered_amount
		if cur_required_resources[resource] <= 0:
			cur_required_resources.erase(resource)
		
		delivery_surplus[resource] -= delivered_amount
		pending_work += delivered_amount
		
	delivery_queue.erase(worker_inventory)
	$MoveItemSound.play()
	
