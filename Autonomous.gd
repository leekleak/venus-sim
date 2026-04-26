extends Node3D

@export var robot1: Robot
@export var robot2: Robot

var start: bool = false

func _physics_process(delta: float) -> void:
	if (!start): return
	var distance = robot1.distance_sensor_1_output
	var color = robot1.color_sensor_1_output
	if (distance > 1.0): robot1.motor_control = Vector2i(1, 0)
	elif (color == Color.WHITE): robot1.motor_control = Vector2i(1, 1)
	
	var distance2 = robot2.distance_sensor_1_output
	var color2 = robot2.color_sensor_1_output
	if (distance2 > 1.0): robot2.motor_control = Vector2i(1, 0)
	elif (color2 == Color.WHITE): robot2.motor_control = Vector2i(1, 1)


func _on_check_button_toggled(toggled_on: bool) -> void:
	start = toggled_on
