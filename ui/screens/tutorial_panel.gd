extends PanelContainer


var focus_nodes = [
	"", "",
	"ScoreContainer",
	"CameraControls",
	"MenuDisplay",
	"WeaponControls",
	"WeaponControls",
	"AmmoDisplay",
	"",
]
var dialogues = [
	"Welcome, new recuit! Fancy yourself an artilleryman in the backlines eh?",
	"Welllll, YOU CANT JUST WADDLE UP HERE SHOOOTIN' CANNONS WITHOUT KNOWING WHAT TO DO! [br]Here are the basics",
	"This shows information about the current battlefield. It shows the battlefield's name and your progress in completing the mission.",
	"These are the camera controls. Toggling this will allow you to freely navigate the battlefield using AWSD or Arrow keys.
[br]You may also use zoom in or out to get a better view of the battlefield (Mouse Scroll Up/Down or -/=)",
	"You can access the menu here to take a quick break from the battle. (Click or ESC to open)(R to quick restart)",
	"Over here are the controls to your cannon. Each weapon will have a power control. In this case, the cannon has a gunpowder slider.
You can set the gunpowder quantity manually using the number input.",
	"Each weapon also comes with an angle slider to adjust to firing angle of your weapon.
When you are done, press FIRE (Mouse Click or SPACE) to shoot.",
	"Be careful! Each weapon has a certain amount of limited ammunition. Keep track of your remaining ammunition.
If you run out before finishing a goal, then you'll fail.",
	"Good luck.",
]

var dialogue_index = 0


func _ready() -> void:
	%DialogueButton.pressed.connect( next_dialogue )
	pass


func start_tutorial():
	dialogue_index = 0
	%DialogueOutput.text = dialogues[0]
	self.show()


func next_dialogue():
	dialogue_index += 1
	if dialogues.size() > dialogue_index:
		%DialogueOutput.text = dialogues[dialogue_index]
		%DialogueOutput.text += "[br][br][i]Click to continue[/i]"
		focus_node()
	else:
		hide()
		pass


func focus_node():
	var node_name: String
	var node: Node

	if dialogue_index >= 1:
		node_name = focus_nodes[dialogue_index - 1]
		if node_name:
			if get_parent().has_node(node_name): node = get_parent().get_node(node_name)
			else: node = get_parent().get_node("%" + node_name)
			node.z_index -= 1
		#print(node_name, node)

	if focus_nodes.size() > dialogue_index:
		node_name = focus_nodes[dialogue_index]
		if node_name:
			if get_parent().has_node(node_name): node = get_parent().get_node(node_name)
			else: node = get_parent().get_node("%" + node_name)
			node.z_index += 1
		print(node_name, node)
	#if node:
		#print(node, node.z_index)
		#if dialogue_index >= 1:
			#if node:
		#node_name = focus_nodes[dialogue_index]
		#print(node_name)
		#if node_name:
			#node = get_parent().get_node("%" + node_name)
	pass
