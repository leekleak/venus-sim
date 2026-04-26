extends Node3D


var last_position = 0
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("lmb")):
		last_position = get_viewport().get_mouse_position().x
	if (Input.is_action_pressed("lmb")):
		var new_position = get_viewport().get_mouse_position().x
		rotation_degrees.y -= (new_position - last_position) / 2
		last_position = new_position
	
