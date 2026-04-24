extends Node3D

@export var robot: Robot
	
func _physics_process(delta: float) -> void:
	var distance = robot.distance_sensor_1_output
	if (distance > 0.2): robot.motor_control = Vector2i(1, 1)
