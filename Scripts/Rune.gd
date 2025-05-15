extends Node

var speed: float = 0
var damage: float = 0
var knockback: float = 0
var SPC = ""
var SSlot = 0
var SPComp = []
var BehaveDict = {"Move": 500, "No_move": 0}
var ElementDict = {
				   "Fire": [5, 0, "res://Assets/Sprites/Poopy temp fire.png"], 
				   "Wind": [3, 2, "res://Assets/Sprites/Poopy temp wind.png"]
					}
var AugmentDict = {
				"Power" = [0.3, 0, 0.5],
				"Speed" = [-0.2, 0.5, 0],
				"None" = [0 ,0 , 0]
}

func SetSpell(SPComp):
	var SendDown = []
	SendDown.append_array(ElementDict[SPComp[0]])
	SendDown.append(BehaveDict[SPComp[1]])
	SendDown.append_array(AugmentDict[SPComp[2]])
	SendDown.append_array(AugmentDict[SPComp[3]])
	SPC.callv("Cast", SendDown)
	SendDown.clear()
	
func GetVars(SpellCasted):
	SPC = get_node(SpellCasted)
	SPC.visible = true
	SPComp = SPC.Vars
	SetSpell(SPComp)
