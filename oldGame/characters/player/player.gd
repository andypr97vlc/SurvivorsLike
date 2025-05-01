extends CharacterBody2D

signal health_depleted
var health = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = 500
	velocity = direction * speed
	
	move_and_slide()
	change_direction()
	
	if velocity.length() > 0:
		%AnimationsPlayer.play_move()
	else: 
		%AnimationsPlayer.play_idle()
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
		

func change_direction():
	var looking_left = false
	if velocity.x < 0:
		looking_left = true
	elif velocity.x > 0:
		looking_left = false
		
	%AnimationsPlayer.flip_h = looking_left
