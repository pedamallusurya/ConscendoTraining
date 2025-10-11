trigger ConCaseCreationTrigger on Contact (after insert) {
        if(Trigger.isAfter && Trigger.isInsert){
            list<Case> newCaseList = new list<Case>();
            for(contact con:trigger.new){
                //if(con.AccountId != null){
                    case newCase = new case();
                    newCase.Status = 'New';
                    newCase.Origin = 'Web';
                    newCase.Subject = 'New Contact Created';
                    newCase.AccountId = con.AccountId;
                    newCase.ContactId = con.Id;
                    newCaseList.add(newCase);
              //  }
            }
           if(!newCaseList.isEmpty()){
                insert newCaseList;
            }
           }
        }