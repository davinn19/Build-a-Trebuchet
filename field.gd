extends Node2D


onready var cam : Camera2D = $Cam
onready var quarry : Quarry = $Quarry
onready var supply_camp : SupplyCamp = $SupplyCamp
onready var trebuchet : Trebuchet = $Trebuchet
onready var command_center : CommandCenter = $CommandCenter

func _ready() -> void:
	cam.current = true
	command_center.create_worker(command_center.miner)
	command_center.create_worker(command_center.woodcutter)
	command_center.create_worker(command_center.builder)


func _process(delta : float) -> void:
	pass
