extends CharacterBody2D


var speed = 500
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	move_and_slide()
	update_animations()
	

func update_animations():
	if velocity.length() > 0:
		animated_sprite.play("move")
	else: 
		animated_sprite.play("idle")
	
	var looking_left = false
	if velocity.x < 0:
		looking_left = true
	elif velocity.x > 0:
		looking_left = false
		
	animated_sprite.flip_h = looking_left
