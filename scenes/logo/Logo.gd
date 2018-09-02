extends Node2D

export(PackedScene) var next_scene;

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene_to(next_scene)
