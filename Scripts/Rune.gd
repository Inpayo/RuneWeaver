extends Node

var speed: float = 0
var damage: float = 0
var knockback: float = 0

var SSlot = 0
var SPComp = []
var SendDown = []
var BehaveDict = {"Move": 50, "No_Move": 0}
var ElementDict = {
				   "Fire": [5, 0, "res://Assets/Sprites/Poopy temp fire.png"], 
				   "Wind": [3, 2, "res://Assets/Sprites/Poopy temp wind.png"]
					}

func SetSpell(SPComp):
	SendDown.append(ElementDict[SPComp[0]])
	SendDown.append(BehaveDict[SPComp[1]])
	SSlot.cast(SendDown)
	
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
	
