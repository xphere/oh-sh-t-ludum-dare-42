extends Node

func on_start(context): pass
func on_stop(): pass
func on_pause(): pass
func on_resume(): pass
func on_event(event_name, context): pass

func set_state(name, context = null): get_parent().set_state(name, context)
func push_state(name, context = null): get_parent().push_state(name, context)
func pop_state(): get_parent().pop_state()
func replace_state(name, context = null): get_parent().replace_state(name, context)
