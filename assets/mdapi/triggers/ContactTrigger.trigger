/* Added */
trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter){
        RollUpSummary summary = RollUpSummary.getInstance();
        if (Trigger.isInsert || Trigger.isUndelete){
            for (Contact c : Trigger.new){
                if (c.AccountId != null){
                    summary.sum(c);
                }
            }
        }
        if (Trigger.isDelete){
            for (Contact c : Trigger.old){
                if (c.AccountId != null){
                    summary.extract(c);
                }
            }
        }
        if (Trigger.isUpdate){
            for (Contact c : Trigger.new){
                if (String.isNotBlank(c.AccountId) && String.isBlank(Trigger.oldMap.get(c.Id).AccountId)){
                    summary.sum(c);
                }else if (String.isBlank(c.AccountId) && String.isNotBlank(Trigger.oldMap.get(c.Id).AccountId)){
                    summary.extract(c);
                }else if (c.AccountId != Trigger.oldMap.get(c.Id).AccountId){
                    summary.sum(c);
                    summary.extract(Trigger.oldMap.get(c.Id));
                }
            }
        }

        summary.calculate();
    }
}