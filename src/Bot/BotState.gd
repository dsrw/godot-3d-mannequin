extends State
class_name BotState
# Base type for the player's state classes. Contains boilerplate code to get
# autocompletion and type hints.


var bot: Bot
var skin: Mannequiny


func _ready() -> void:
	yield(owner, "ready")
	bot = owner
	skin = owner.skin
