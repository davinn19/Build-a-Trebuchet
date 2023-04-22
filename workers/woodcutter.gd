class_name Woodcutter
extends Worker


func _process(delta : float) -> void:
	# TODO implement
	if is_asleep:
		return
		
	if is_idle:
		if !has_target_tree():
			find_target_tree()
			
		else:
			move_to_target(cur_tree, 200)
			connect("finished_moving", self, )


func has_target_tree() -> bool:
	return cur_tree and cur_tree.has_chops()


func find_target_tree() -> void:
	var cur_tree : TreeResource = field.get_tree_resource()
	if !cur_tree:
		is_asleep = true
	else:
		cur_tree.connect("tree_felled", self, "on_tree_felled")


func on_tree_felled() -> void:
	cur_tree = null
	is_idle = true


func chop_tree() -> void:
	play_anim("work")
