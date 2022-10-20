"use strict";

GameUI.SetCameraDistance( 1200 );

var PetSelectionRootPanel = $("#PetSelectionRoot");
var SecondAbilitySelectionRootPanel  = $("#SecondAbilitySelectionRoot");

function CooldownPetButtonPressed() {
	Game.EmitSound("HeroBadgeLevelUpReward.ShowReward")
	PetSelectionRootPanel.visible = !PetSelectionRootPanel.visible;
	GameEvents.SendCustomGameEventToServer("CooldownPetButtonPressed", {});
}

function ExperiencePetButtonPressed() {
	Game.EmitSound("HeroBadgeLevelUpReward.ShowReward")
	PetSelectionRootPanel.visible = !PetSelectionRootPanel.visible;
	GameEvents.SendCustomGameEventToServer("ExperiencePetButtonPressed", {});
}

function Ability1Selected() {
	Game.EmitSound("HeroBadgeLevelUpReward.ShowReward")
	SecondAbilitySelectionRootPanel.visible = !SecondAbilitySelectionRootPanel.visible;
	GameEvents.SendCustomGameEventToServer("Ability1Selected", {});
}

function Ability2Selected() {
	Game.EmitSound("HeroBadgeLevelUpReward.ShowReward")
	SecondAbilitySelectionRootPanel.visible = !SecondAbilitySelectionRootPanel.visible;
	GameEvents.SendCustomGameEventToServer("Ability2Selected", {});
}

function Ability3Selected() {
	Game.EmitSound("HeroBadgeLevelUpReward.ShowReward")
	SecondAbilitySelectionRootPanel.visible = !SecondAbilitySelectionRootPanel.visible;
	GameEvents.SendCustomGameEventToServer("Ability3Selected", {});
}

function PopupPetRootPanel(data) {
	PetSelectionRootPanel.visible = !PetSelectionRootPanel.visible;
}

function PopupSecondAbilityRootPanel(data) {
	SecondAbilitySelectionRootPanel.visible = !SecondAbilitySelectionRootPanel.visible;
}

(function () {
	GameEvents.Subscribe("player_reached_pet_level", PopupPetRootPanel);
	GameEvents.Subscribe("player_reached_secondability_level", PopupSecondAbilityRootPanel);
})();