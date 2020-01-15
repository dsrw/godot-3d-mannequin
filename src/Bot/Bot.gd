tool
class_name Bot
extends KinematicBody
# Helper class for the Player scene's scripts to be able to have access to the
# camera and its orientation.

onready var skin: Mannequiny = $Mannequiny
onready var state_machine: StateMachine = $StateMachine
var current_command = null
var co = null
var timer = null
var semaphore = Semaphore.new()
var timer_thread = null
var rules_thread = null

func _ready():
	yield(owner, "ready")
	state_machine.transition_to("Move/Run")
	rules_thread = Thread.new()
	rules_thread.start(self, "_buildrules")

func _buildrules(userdata):
	self.rules()
	self.current_command = null


func rules():
	pass

func _set_current_command(command):
	print("current_command: " + command)
	self.current_command = command
	_wait()

func move_forward(distance = 1):
	_set_current_command("move_forward")


func move_backward(distance = 1):
	_set_current_command("move_backward")


func move_left(distance = 1):
	_set_current_command("move_left")

func move_right(distance = 1):
	_set_current_command("move_right")


func turn_left(degrees = 90):
	_set_current_command("turn_left")


func turn_right(degrees = 90):
	_set_current_command("turn_right")


func jump(velocity = 25):
	_set_current_command("jump")


func _wait(seconds = 1.0):
	timer_thread = Thread.new()
	timer_thread.start(self, "_bump_timer", seconds)
	semaphore.wait()

func _bump_timer(seconds):
	yield(get_tree().create_timer(seconds), "timeout")
	semaphore.post()

