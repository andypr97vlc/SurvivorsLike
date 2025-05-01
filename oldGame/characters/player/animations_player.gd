extends AnimatedSprite2D

func play_idle():
	%AnimationsPlayer.play("idle")

func play_move():
	%AnimationsPlayer.play("move")
	
func play_hurt():
	%AnimationsPlayer.modulate = Color(1, 0.4, 0.4)  # tono rojizo
	await get_tree().create_timer(0.2).timeout
	%AnimationsPlayer.modulate = Color(1, 1, 1)  # volver a color normal
