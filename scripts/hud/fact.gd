extends Window

var facts = [
	"Levels 3 and 4 were meant to be the first 2 levels!",
	"This was made for the Hack Club Milkyway game Jam!",
	"The Micheal approches quick!",
	"This game is spaghetti coded!",
	"I will lose my mind if someone wants another feature.",
	"This entire game was made on FOSS!",
	"Godot + Libresprite + Linux <3"
]

func _ready() -> void:
	$VBoxContainer/FactLabel.text = facts.pick_random()
	self.close_requested.connect(handle_close)
	
func handle_close():
	self.visible = false
