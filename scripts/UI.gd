extends Control

@export var robot1: Robot
@export var robot2: Robot
@onready var label: Label = $Label
@onready var label2: Label = $Label2

func _physics_process(delta: float) -> void:
	label.text = """
	ROBOT 1:
	Distance sensor 1: %2.2fm
	Color sensor 1: %s
	""" % [robot1.distance_sensor_1_output, robot1.color_sensor_1_output]
	label2.text = """
	ROBOT 2:
	Distance sensor 1: %2.2fm
	Color sensor 1: %s
	""" % [robot2.distance_sensor_1_output, robot2.color_sensor_1_output]


func _on_h_slider_value_changed(value: float) -> void:
	Engine.time_scale = value
