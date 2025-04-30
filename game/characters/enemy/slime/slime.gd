extends CharacterBody2D

# Nodo del jugador y variables
@onready var player = get_node("/root/game/player")
var health = 3
var dead = false

func _ready() -> void:
	if !dead:
		%AnimationsSlime.play_move()
		
func _physics_process(delta: float) -> void:
	# Si no está muerto se moverá en direccion al jugador
	if !dead:
		var direction = global_position.direction_to(player.global_position)
		var speed = 300
		velocity = direction * speed
	else:
		# Deja la velocidad a 0 para que se ejecute la animación de muerte sin que se mueva del sitio
		velocity = Vector2.ZERO
		%AnimationsSlime.play_death()
		# Crea uyn timer con los frames del sprite y la velocidad, una vez termina el timeout, se ejecuta la siguiente acción, en este caso el nodo se destruiría
		var frames = $AnimationsSlime.sprite_frames.get_frame_count("death")
		var speed = $AnimationsSlime.sprite_frames.get_animation_speed("death")
		var duration = frames / speed
		await get_tree().create_timer(duration).timeout
		queue_free()
				
	move_and_slide()
	change_direction()

# Funcion que cambia la dirección del sprite dependiendo de hacia que dirección mire
func change_direction():
	var looking_left = false
	if velocity.x < 0:
		looking_left = true
	elif velocity.x > 0:
		looking_left = false
		
	%AnimationsSlime.flip_h = looking_left

# Funcion de recibir daño (conectada con arrow), cada vez que se activa reduce la vida del enemigo en 1
func take_damage():
	health -= 1
	# Si tiene 0 de vida muere en caso contrario ejecuta la animación de ser atacado
	if health == 0:
		dead = true
	elif !dead:
		%AnimationsSlime.play_hurt()
