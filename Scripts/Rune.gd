extends Node

var speed: float = 0
var damage: float = 0
var knockback: float = 0

var SSlot = 0
var SPComp = []
var BehaveDict = {"Move": 500, "No_move": 0}
var ElementDict = {
				   "Fire": [5, 0, "res://Assets/Sprites/Poopy temp fire.png"], 
				   "Wind": [3, 2, "res://Assets/Sprites/Poopy temp wind.png"]
					}

func SetSpell(SPComp):
	var SendDown = []
	SendDown.append_array(ElementDict[SPComp[0]])
	SendDown.append(BehaveDict[SPComp[1]])
	print(SendDown)
	SSlot.callv("Cast", SendDown)
	SendDown.clear()
	
func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SP1"):
		SSlot = $SP1
		SPComp = SSlot.Vars
		SetSpell(SPComp)
	if Input.is_action_just_pressed("SP2"):
		SSlot = $SP2
		SPComp = SSlot.Vars
		SetSpell(SPComp)
	if Input.is_action_just_pressed("SP3"):
		SSlot = $SP3
		SPComp = SSlot.Vars
		SetSpell(SPComp)
	
