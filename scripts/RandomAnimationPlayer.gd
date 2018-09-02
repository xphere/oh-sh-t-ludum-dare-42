extends AnimationPlayer


func _init():
	connect("animation_finished", self, "play_random_animation")


func play_random_animation(last_animation):
	var animations = get_animation_list()
	var animation_size = animations.size()
	while true:
		var animation_index = int(floor(randf() * animation_size))
		var animation = animations[animation_index]
		if animation != last_animation:
			play(animations[animation_index])
			break
