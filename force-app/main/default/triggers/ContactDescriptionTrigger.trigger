trigger ContactDescriptionTrigger on Contact (before insert) {
    ContactTriggerHandler.Handler(Trigger.new);
}