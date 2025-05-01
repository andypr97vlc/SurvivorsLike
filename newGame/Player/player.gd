extends CharacterBody2D

var movement_speed = 40.0
var hp = 80
@onready var sprite = $Sprite2D
@onready var walk_timer = get_node("WalkTimer")

func _physics_process(_delta: float) -> void:
	movement()
	
func movement():
	# Calculo del vector de direcciones para asignar una velocidad equivalente
	var direction = Input.get_vector("key_left", "key_right", "key_up", "key_down")
	velocity = direction.normalized() * movement_speed
	
	# Girar sprite en la dirección en la que se mueve el jugador
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	
	# Si hay movimiento se reproducirá el sprite
	if velocity != Vector2.ZERO:
		if walk_timer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walk_timer.start()
	
	move_and_slide()

# Funcion que recibe la señal de daño con su cantidad y la resta a la vida
func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	print(hp)
