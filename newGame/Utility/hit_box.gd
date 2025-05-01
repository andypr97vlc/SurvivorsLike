extends Area2D

@export var damage = 1 # @export Crea un apartado en el "Inspector" para poder elegir el daño
@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableHitBoxTimer

func temp_disable():
	collision.call_deferred("set", "disabled", true) # Desactiva la HitBox 
	disable_timer.start() # Inicia el contador que desactiva la HitBox por 0.5s


func _on_disable_hit_box_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false) # Reactiva la HitBox
