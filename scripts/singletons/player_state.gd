extends Node

var hunger := 0
var social := 0
var sleep_debt := 0
var inventory := []
var equipped := {}
var skills := {}

func to_dict() -> Dictionary:
	return {
		"hunger": hunger,
		"social": social,
		"sleep_debt": sleep_debt,
		"inventory": inventory,
		"equipped": equipped,
		"skills": skills
	}

func from_dict(data: Dictionary) -> void:
	hunger = data.get("hunger", 0)
	social = data.get("social", 0)
	sleep_debt = data.get("sleep_debt", 0)
	inventory = data.get("inventory", [])
	equipped = data.get("equipped", {})
	skills = data.get("skills", {})
