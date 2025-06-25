extends Level


func _on_door_body_entered(_body: Node3D) -> void:
	switch_level("dungeon")
