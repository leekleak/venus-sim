extends Control

@export var robot: Robot
@onready var label: Label = $Label

func _physics_process(delta: float) -> void:
	label.text = """
	Distance sensor 1: %2.2fm
	Color sensor 1: %s
	""" % [robot.distance_sensor_1_output, robot.color_sensor_1_output]
