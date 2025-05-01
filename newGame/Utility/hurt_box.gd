extends Area2D

@export_enum("Cooldown", "Hit once", "Disabled HitBox") var hurt_box_type = 0 # @export_enum Crea un desplegable en el "Inspector" para poder elegir las opciones propuestas

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"): # Cuando un area del grupo "attack" entra en la HitBox
		if not area.get("damage") == null: # Comprueba si tiene asociado un "var damage"
			match hurt_box_type: # Miramos el tipo de HurtBox
				0: # Cooldown
					collision.call_deferred("set", "disabled", true) # Desactiva la HurtBox
					disable_timer.start() # Activa el timer para no recibir más daño durante 0.5s
				1: # HitOnce
					pass
				2: # DisabledHitBox
					if area.has_method("temp_disable"): # Comprueba si "area" tiene el método "temp_disable"
						area.temp_disable() # Llama la función
			var damage = area.damage
			emit_signal("hurt", damage) # Independientemente de si "collision" está activado/desactivado el daño de area se enviará a la señal. Que cuando se conecte a nuestro jugador o enemigo, recibirá el daño

func _on_disable_timer_timeout() -> void: # Reactiva la HurtBox
	collision.call_deferred("set", "disabled", false)
	
