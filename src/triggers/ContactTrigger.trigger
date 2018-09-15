trigger ContactTrigger on Contact (before insert,before update,before delete,after undelete) {
    
    if(trigger.isbefore && trigger.isinsert){
        ContactManager.handleInsert(trigger.new);
    }
	
    if(trigger.isbefore && trigger.isupdate){
        ContactManager.handleUpdate(trigger.new,trigger.oldMap);
    }
    
    if(trigger.isbefore && trigger.isdelete){
        ContactManager.handleDelete(trigger.old);
    }
    
    if(trigger.isafter && trigger.isundelete){
        ContactManager.handleUndelete(trigger.new);
    }
    
}