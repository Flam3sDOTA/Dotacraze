"use strict";

GameUI.SetCameraDistance( 1200 );

var PetSelectionRootPanel = $("#PetSelectionRoot");

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

function PopupPetRootPanel(data) {
	PetSelectionRootPanel.visible = !PetSelectionRootPanel.visible;
}

(function () {
	GameEvents.Subscribe("player_reached_pet_level", PopupPetRootPanel);
})();