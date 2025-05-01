extends CharacterBody2D

@export var movement_speed = 20.0 # @export Crea un apartado en el "Inspector" para poder elegir la velocidad
var hp = 10
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var animation_walk = $AnimationPlayer


func _ready() -> void:
	animation_walk.play("walk")


func _physics_process(_delta: float) -> void:
	# Movimiento del personaje
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()
	
	# Girar sprite en la dirección en la que se mueve el jugador
	if velocity.x > 0.1:
		sprite.flip_h = true
	elif velocity.x < -0.1:
		sprite.flip_h = false


func _on_hurt_box_hurt(damage: Variant) -> void: # Funcion que recibe la señal de daño con su cantidad y la resta a la vida
	hp -= damage
	if hp <= 0: # Si tiene menos de 0 de vida liberamos el nodo (matamos el proceso)
		queue_free()
