extends Node3D

func _ready() -> void:
	$"../Control/HSlider".value = rotation_degrees.y
func _on_h_slider_value_changed(value: float) -> void:
	rotation_degrees.y = value
