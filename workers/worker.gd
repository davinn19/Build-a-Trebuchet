class_name Worker
extends Node


onready var character_rig : CharacterRig = get_parent()

var cur_state : int = WorkerState.IDLE
var field : Field



func _init(field : Field) -> void:
	self.field = field
	pass


func _ready():
	field = get_node("../../")
	play_anim("idle")


func _process(delta : float) -> void:
	pass


func play_anim(anim_name : String) -> void:
	assert(character_rig.anim.has_animation(anim_name))
	character_rig.anim.play(anim_name)
