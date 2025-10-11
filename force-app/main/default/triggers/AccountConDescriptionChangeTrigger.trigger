trigger AccountConDescriptionChangeTrigger on Account (After Update) {
     AccountConHandler.Handler(Trigger.new,Trigger.oldMap);
}