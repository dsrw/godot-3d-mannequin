extends BotState
# Parent state for all movement-related states for the Player.
# Holds all of the base movement logic.
# Child states can override this state's functions or change its properties.
# This keeps the logic grouped in one location.


export var max_speed: = 50.0
export var move_speed: = 500.0
export var gravity = -80.0
export var jump_impulse = 25

var velocity: = Vector3.ZERO
var current_move = null
var time = 0.0


func unhandled_input(event: InputEvent) -> void:
	pass
	#if event.is_action_pressed("jump"):
	#	_state_machine.transition_to("Move/Air", { velocity = velocity, jump_impulse = jump_impulse })


func physics_process(delta: float) -> void:
	#var input_direction: = get_input_direction()

	# Calculate a move direction vector relative to the camera
	# The basis stores the (right, up, -forwards) vectors of our camera.

	#var forwards: Vector3 = player.camera.global_transform.basis.z * input_direction.z
	#var right: Vector3 = player.camera.global_transform.basis.x * input_direction.x
	#var move_direction: = forwards + right
	#if move_direction.length() > 1.0:
	#	move_direction = move_direction.normalized()

	#move_direction.y = 0
	#skin.move_direction = move_direction

	# Rotation
	#if move_direction:
	#	player.look_at(player.global_transform.origin + move_direction, Vector3.UP)

	# Movement
	#velocity = calculate_velocity(velocity, move_direction, delta)
	#velocity = player.move_and_slide(velocity, Vector3.UP)

	#if current_move == null && !bot.moves.empty():
	#	current_move = bot.moves.pop_front()
	#	time = 0.0

	#if time > 1.0:
	#	current_move = null
	var facing = bot.global_transform.basis.z
	match bot.current_command:
		"move_forward":
			bot.move_and_slide(-facing * 2, Vector3.UP)
		"move_backward":
			bot.move_and_slide(facing * 2, Vector3.UP)
		"turn_left":
			bot.rotate(Vector3.UP, deg2rad(90 * delta))
		"turn_right":
			bot.rotate(Vector3.UP, deg2rad(-90 * delta))

	pass

func enter(msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


# Callback to transition to the optional Zip state
# It only works if the Zip state node exists.
# It is intended to work via signals
func _on_Camera_aim_fired(target_vector: Vector3) -> void:
	_state_machine.transition_to("Move/Zip", { target = target_vector })



func calculate_velocity(
		velocity_current: Vector3,
		move_direction: Vector3,
		delta: float
	) -> Vector3:
		var velocity_new: = velocity_current

		velocity_new = move_direction * delta * move_speed
		if velocity_new.length() > max_speed:
			velocity_new = velocity_new.normalized() * max_speed
		velocity_new.y = velocity_current.y + gravity * delta

		return velocity_new
