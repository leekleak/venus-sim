extends Node3D

@export var robot: Robot

var start: bool = false

func _physics_process(delta: float) -> void:
	if (!start): return
	var distance = robot.distance_sensor_1_output
	var color = robot.color_sensor_1_output
	if (distance > 1.0): robot.motor_control = Vector2i(1, 0); return
	if (color == Color.WHITE): robot.motor_control = Vector2i(1, 1); return


func _on_check_button_toggled(toggled_on: bool) -> void:
	start = toggled_on
