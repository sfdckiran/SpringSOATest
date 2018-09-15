({
    onInit : function(component,event,helper){
        var action = component.get("c.getAccounts");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
                var toastEvent = $A.get("e.force:showToast");
                const accountWrapper = response.getReturnValue();
                component.set("v.accounts",accountWrapper.accountsList);
                const numberOfAccounts = accountWrapper.accountsList.length;
                if(numberOfAccounts > 0){
                    helper.setAccountId(component,event,helper,accountWrapper);
                }
                toastEvent.setParams({
                    "type":"success",
                    "title":"Success",
                    "message":"Account List is loaded",
                    "mode":"dismissible"
                });
                toastEvent.fire();
            }
            else{
                toastEvent.setParams({
                    "type":"error",
                    "message":"An error occured while fetching accounts"+accountWrapper.message(),
                    "mode":"sticky"
                 });
                toastEvent.fire();
            }
            
        });
        $A.enqueueAction(action);
    },
    
    setAccountId : function(component,event,helper,accountWrapper){//To set accountid for each record to help navigation
        console.log(accountWrapper);
        var accountIdReference = component.find("accountId");
        console.log(accountIdReference);
        if(Array.isArray(accountIdReference)){
            for(var i=0;i<accountIdReference.length;i++){
                accountIdReference[i].set("v.value",accountWrapper.accountsList[i].Id);
            }
        }
        else{
            accountIdReference.set("v.value",accountWrapper.accountsList[0].Id);
        }
    }
})