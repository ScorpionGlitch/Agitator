extends Control

class_name DialogUI

# error is deliberate, continue watching tutorial
#https://youtu.be/Jy20MdEFxcY?t=504
@onready var panel = $CanvasLayer/Panel
@onready var dialog_speaker = $CanvasLayer/Panel/DialogBox/DialogSpeaker
@onready var dialog_text = $CanvasLayer/Panel/DialogBox/DialogText
@onready var dialog_options = $CanvasLayer/Panel/DialogBox/DialogOptions
