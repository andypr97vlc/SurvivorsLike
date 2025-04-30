extends AnimatedSprite2D

func play_move():
	%AnimationsSlime.play("move")
	
func play_hurt():
	%AnimationsSlime.modulate = Color(1, 0.4, 0.4)  # tono rojizo
	await get_tree().create_timer(0.2).timeout
	%AnimationsSlime.modulate = Color(1, 1, 1)  # volver a color normal
	
func play_death():
	%AnimationsSlime.play("death")
