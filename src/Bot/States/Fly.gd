extends PlayerState
# State for when the player is flying

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air")


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.flying = true
	_parent.enter()


func exit() -> void:
	_parent.flying = false
	_parent.exit()
