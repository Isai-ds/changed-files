trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter){        

        if (Trigger.isDelete){
            for (Opportunity opp : Trigger.old){
                RollupLookUp.getInstance().add(opp);
            }

        }else{
            if (Trigger.isInsert || Trigger.isUndelete){
                for (Opportunity opp : Trigger.new){
                    RollupLookUp.getInstance().add(opp);
                }
            }else{
                for (Opportunity opp : Trigger.new){
                    if (opp.AccountId != Trigger.oldMap.get(opp.Id).AccountId){
                        RollupLookUp.getInstance().add(opp);
                        RollupLookUp.getInstance().add(Trigger.oldMap.get(opp.Id));
                    }
                }
            }
        }
        RollupLookUp.getInstance().calculate();
        
    }
}       