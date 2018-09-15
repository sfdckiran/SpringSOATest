({
    
    onInit : function(component,event,helper){
        helper.onInit(component,event,helper);
    },
    
    handleNavigation : function(component,event,helper){
        var targetId = event.getSource().get("v.value");
        var navigator = $A.get("e.force:navigateToSObject");//Initializing navigation event
        navigator.setParams({
            "recordId":targetId,
            "slideDevName":"detail"
        });
        navigator.fire();
    },
    
    doRefresh : function(component,event,helper){
        component.set("v.accounts",null);
        helper.onInit(component,event,helper);
    }
})