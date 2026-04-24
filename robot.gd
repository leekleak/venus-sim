class_name Robot
extends CharacterBody3D

@export var manual: bool = false
@onready var wheel_l: MeshInstance3D = $WheelL
@onready var wheel_r: MeshInstance3D = $WheelR
@onready var color_sensor_1: RayCast3D = $ColorSensor1
@onready var distance_sensor_1: RayCast3D = $DistanceSensor1
var rotationSpeed = 2

var distance_sensor_1_output: float = 10.0
var color_sensor_1_output: Color = Color.WHITE

var motor_control: Vector2i = Vector2i(0, 0)

func _physics_process(delta: float) -> void:
	var left = Input.is_action_pressed("left") if (manual) else motor_control.x
	var right = Input.is_action_pressed("right") if (manual) else motor_control.y
	motor_control = Vector2i(0, 0)
	
	var target_velocity = Vector3.ZERO
	var rotation_amount = 0.0

	if left and right:
		target_velocity = -global_transform.basis.z * (rotationSpeed / 6.0)
	elif left:
		var pivot = wheel_l.global_position
		rotation_amount = rotationSpeed * delta
		target_velocity = calculate_pivot_velocity(pivot, rotation_amount, delta)
		rotate_y(rotation_amount)
	elif right:
		var pivot = wheel_r.global_position
		rotation_amount = -rotationSpeed * delta
		target_velocity = calculate_pivot_velocity(pivot, rotation_amount, delta)
		rotate_y(rotation_amount)
	velocity = target_velocity
	move_and_slide()
		
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
