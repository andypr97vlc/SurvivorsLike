extends CharacterBody2D


var speed = 300
@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_node("/root/game/player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	move_and_slide()
	update_animations()

func update_animations():
	animated_sprite.play("move")
	
	var looking_left = false
	if velocity.x < 0:
		looking_left = true
	elif velocity.x > 0:
		looking_left = false
		
	animated_sprite.flip_h = looking_left
