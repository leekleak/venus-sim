extends Node3D

@export var robots: Array[Robot]

var start: bool = false

func _physics_process(delta: float) -> void:
	if (!start): return
	for i in robots: robot_logic(i)

func _on_check_button_toggled(toggled_on: bool) -> void:
	start = toggled_on
	if (!start):
		get_tree().reload_current_scene()
	

#
#
# Edit only the following function:
#
#

func robot_logic(robot: Robot):
	var distance = robot.distance_sensor_1_output
	var color = robot.color_sensor_1_output
	if (distance > 1.0): robot.motor_control = Vector2(0, 0.5)
	elif (color == Color.WHITE): robot.motor_control = Vector2(1, 1)
