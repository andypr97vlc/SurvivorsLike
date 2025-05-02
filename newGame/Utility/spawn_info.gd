extends Resource

# Creacion de interfaz para spawnear monstruos
class_name Spawn_info

@export var time_start:int # Cuando empieza a spawnear
@export var time_end:int # Cuadno termina de spawnear
@export var enemy:Resource # Que spawnea
@export var enemy_num:int # Cantidad de enemigos que spawnea
@export var enemy_spawn_delay:int # Segundos de delay entre spawns

var spawn_delay_counter = 0 # Seguimiento del delay entre spawns
