extends Control

onready var text_edit = $TextEdit
onready var animation_player = $AnimationPlayer
onready var popup = $Popup
onready var popup_timer = $PopupTimer

#var converted_column : int = 0
#var input : String = ""

var input : String = ""
var converted_column : int = 0
var convert_queue : Array = []

var colemak_dict : Dictionary = {
	"q": "q",
	"w": "w",
	"e": "f",
	"r": "p",
	"t": "g",
	"y": "j",
	"u": "l",
	"i": "u",
	"o": "y",
	"p": ";",
	"a": "a",
	"s": "r",
	"d": "s",
	"f": "t",
	"g": "d",
	"h": "h",
	"j": "n",
	"k": "e",
	"l": "i",
	";": "o",
	"z": "z",
	"x": "x",
	"c": "c",
	"v": "v",
	"b": "b",
	"n": "k",
	"m": "m",
	"Q": "Q",
	"W": "W",
	"E": "F",
	"R": "P",
	"T": "G",
	"Y": "J",
	"U": "L",
	"I": "U",
	"O": "Y",
	"P": ";",
	"A": "A",
	"S": "R",
	"D": "S",
	"F": "T",
	"G": "D",
	"H": "H",
	"J": "N",
	"K": "E",
	"L": "I",
	":": "O",
	"Z": "Z",
	"X": "X",
	"C": "C",
	"V": "V",
	"B": "B",
	"N": "K",
	"M": "M",

}


func _ready():
	text_edit.grab_focus()


func _input(event):
	if event.is_action_pressed("copy"):
		OS.set_clipboard(text_edit.text)
		text_edit.text = ""
		
		popup.popup_centered()
		animation_player.play("popup")
		popup_timer.start()


func _on_TextEdit_text_changed():
	# if going forward
	if text_edit.cursor_get_column() > converted_column:
		input = text_edit.text[-1]
		convert_queue.append(input)
	
	# needed a queue to make it faster
	for character in convert_queue:
		if colemak_dict.has(convert_queue[0]):
			text_edit.text[-1] = colemak_dict[convert_queue.pop_front()]
		else:
			text_edit.text[-1] = convert_queue.pop_front()
		
		text_edit.cursor_set_column(1000000000)
	
	converted_column = text_edit.cursor_get_column()


func _on_PopupTimer_timeout():
	popup.hide()
