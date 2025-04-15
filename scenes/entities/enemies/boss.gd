extends EnemyCommon

@onready var skin = $NagonfordSkin
@onready var player = get_node("../Entities/Player")

@export var base_speed := 2.0

var speed_modifier := 1.0
var player_nearby: bool = true

func _physics_process(delta: float) -> void:
	move_logic(delta)
	jump_logic(delta)
	move_and_slide()


func move_logic(delta: float) -> void:
	var velocity_2d = Vector2(velocity.x, velocity.z)

	if player_nearby:	
		var direction_to_player = position.direction_to(player.position)
		var direction_2d = Vector2(direction_to_player.x, direction_to_player.z)
		var target_angle = -direction_2d.angle() + PI/2
		skin.rotation.y = rotate_toward(skin.rotation.y, target_angle, 6.0 * delta)
		velocity_2d += direction_2d * base_speed * delta * 8.0
		velocity_2d = velocity_2d.limit_length(base_speed) * speed_modifier
		velocity.x = velocity_2d.x
		velocity.z = velocity_2d.y
		print(position.distance_to(player.position))
		if position.distance_to(player.position) < 2.1:
			skin.set_move_state("Idle")
		else:
			skin.set_move_state("Walking")
		
	else:
		velocity_2d = velocity_2d.move_toward(Vector2.ZERO, base_speed * 4.0 * delta)
		velocity.x = velocity_2d.x
		velocity.z = velocity_2d.y
		skin.set_move_state("Idle")
		
func jump_logic(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 9.8 * delta
