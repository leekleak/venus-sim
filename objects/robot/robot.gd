class_name Robot
extends CharacterBody3D

@export var manual: bool = false
@onready var color_sensor_1: RayCast3D = $ColorSensor1
@onready var distance_sensor_1: RayCast3D = $DistanceSensor1
var rotationSpeed = 1

var distance_sensor_1_output: float = 10.0
var color_sensor_1_output: Color = Color.WHITE

var motor_control: Vector2 = Vector2(0, 0)
var track_width: float = 0.14 
@export var max_speed: float = 0.5

func _physics_process(delta: float) -> void:
	var left = Input.get_action_strength("left") if (manual) else motor_control.x
	var right = Input.get_action_strength("right") if (manual) else motor_control.y
	
	motor_control = Vector2.ZERO
	var v_left = left * max_speed
	var v_right = right * max_speed
	var linear_v = (v_left + v_right) / 2.0
	var angular_v = (v_right - v_left) / track_width
	rotate_y(angular_v * delta)
	
	velocity = -global_transform.basis.z * linear_v
	move_and_slide()

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			c.get_collider().apply_central_impulse(-c.get_normal() * 1)
		
	# Distance 1
	var collider = distance_sensor_1.get_collider()
	if (collider != null):
		var point = distance_sensor_1.get_collision_point()
		distance_sensor_1_output = (point - distance_sensor_1.global_position).length()
	else: 
		distance_sensor_1_output = 10.0
		
	# Color 1
	var body = color_sensor_1.get_collider()
	if (body is ColorObject):
		color_sensor_1_output = body.color

func calculate_pivot_velocity(pivot: Vector3, angle: float, delta: float) -> Vector3:
	var local_offset = global_position - pivot
	var rotated_offset = Basis(Vector3.UP, angle) * local_offset
	var target_pos = pivot + rotated_offset
	
	return (target_pos - global_position) / delta
