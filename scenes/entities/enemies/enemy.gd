class_name Enemy
extends CharacterBody3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var skin = get_node("Skin")

@export var base_speed := 2.0
@export var notice_radius:= 30
@export var attack_radius:= 3

func move_to_player(delta):
	if position.distance_to(player.position) < notice_radius:
		var target_dir = (player.position - position).normalized()
		var target_vec2 = Vector2(target_dir.x, target_dir.z)
		var target_angle = -target_vec2.angle() + PI/2
		rotation.y = rotate_toward(rotation.y, target_angle, delta * 6.0)
		if position.distance_to(player.position) > attack_radius:
			velocity = Vector3(target_vec2.x, 0, target_vec2.y ) * base_speed
			move_state_machine.travel("walk")
		else:
			velocity = Vector3.ZERO
			move_state_machine.travel("idle")
		move_and_slide()
	else:
		move_state_machine.travel("idle")
