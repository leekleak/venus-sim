@tool
extends ColorObject

func _ready() -> void:
	update_color()
	
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()): update_color()
		

func update_color():
	var newMaterial = StandardMaterial3D.new()
	newMaterial.albedo_color = color
	$MeshInstance3D.material_override = newMaterial
