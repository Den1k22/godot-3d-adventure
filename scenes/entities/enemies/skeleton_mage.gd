extends Enemy

func _physics_process(delta: float) -> void:
	move_to_player(delta)


func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = rng.randf_range(4.0, 5.5)
	if position.distance_to(player.position) < attack_radius:
		range_attack_animation()


func range_attack_animation() -> void:
	stop_movement(0.5, 0.5)
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func shoot_fireball() -> void:
	var pos = $Skin/Rig/Skeleton3D/BoneAttachment3D/wand2/Marker3D.global_position
	var direction = (player.position - position).normalized()
	var direction_2d = Vector2(direction.x, direction.z)
	cast_spell.emit("fireball", pos, direction_2d, 1.0)
