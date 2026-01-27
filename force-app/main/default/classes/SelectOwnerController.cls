public class SelectOwnerController {
    public String selectedUserId { get; set; }
    
    public List<SelectOption> userOptions { get; set; }

    public String selectedQueueId { get; set; }

    public List<SelectOption> queueOptions { get; set; }

    public List<Case> selectedCases { get; set; }

    public String ids { get; set; }


    public Boolean isSuccess { get; set; }
    
    public Boolean isDisabled { get; set; }

    public Boolean isEmpty { get; set; }

    public Boolean isClosed { get; set; }

    public Boolean isDispatcher { get; set; }


    public SelectOwnerController() {
         ids = ApexPages.currentPage().getParameters().get('ids');
        queueOptions = new List<SelectOption>();
        queueOptions.add(new SelectOption('', '-- Select Queue --'));
        isDispatcher = false;
        List<GroupMember> groupMembers = [select id,group.name,UserOrGroupId from GroupMember where group.name like'%dispatcher%'];
        System.debug('groupMembers: ' + groupMembers.size());
        for(GroupMember itemGm : groupMembers) {
            if(itemGm.UserOrGroupId == UserInfo.getUserId()){ 
                isDispatcher = true;
                break;
            }
        }
        System.debug('isDispatcher: ' + isDispatcher);
        if(!isDispatcher) {
            return;
        }

        // Cek apakah user adalah admin (misal: Profile Name = 'System Administrator')
        String profileName = [SELECT Profile.Name FROM User WHERE Id = :UserInfo.getUserId()].Profile.Name;

        List<Case> closeds = new List<Case>();
        
        List<Group> queues =  new List<Group>() ;

        if(profileName == 'System Administrator') {
            // Jika admin, tampilkan semua Queue
            List<Group>   queueList = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name Like '%AMFS E2C%' ORDER BY Name ];
            for (Group g : queueList) {
                if(!g.Name.contains(System.Label.AMFS_Queue_AOH)){
                    queues.add(g);
                }
            }

        } else {
            // Logic existing untuk user biasa

            System.debug('User ID: ' + UserInfo.getUserId());
            List<GroupMember> gms = [SELECT Id,GroupId, group.Name FROM GroupMember WHERE  UserOrGroupId = :UserInfo.getUserId() ];
            System.debug('Group Members Size: ' + gms.size());
            
            List<Id> gmIds = new List<Id>();

            for(GroupMember gm : gms){
                    if(gm.Group.Name.contains('AMFS E2C')){
                        System.debug('AMFSe2c - Group ID: ' + gm.GroupId);
                        System.debug('AMFSe2c - Group Name: ' + gm.Group.Name);
                         gmIds.add(gm.GroupId);   
                        
                     }

            }
            System.debug('AMFSe2c - Group Member IDs: ' + gmIds);
            
            List<GroupMember> queuesGroup = [SELECT Id,GroupId ,UserOrGroupId FROM GroupMember WHERE UserOrGroupId In :gmIds ];
            List<Id> queueIds = new List<Id>(); 
            for(GroupMember gm : queuesGroup){
                System.debug('AMFSe2c Queue Group ID: ' + gm.GroupId);
                
                queueIds.add(gm.GroupId);
            }
            queues = [SELECT Id, Name FROM Group WHERE Id IN :queueIds];
        }

        for (Group g : queues) {
            if(!g.Name.contains(System.Label.AMFS_Queue_AOH)){
                queueOptions.add(new SelectOption(g.Id, g.Name));
               // Skip queues with AOH in the name
            }
        }

        List<Id> caseIdList = new List<Id>();
        if (String.isNotBlank(ids)) {
            for (String idStr : ids.split(',')) {
                caseIdList.add(idStr.trim());
            }
        }
        List<Case> cases = [SELECT CaseNumber, Subject, Status, Owner.Name FROM Case WHERE Id IN :caseIdList];

        System.debug(' Case size : '+cases.size());
        selectedCases = new List<Case>();
        for (Case itemCase : cases) {
            if(itemCase.Status == 'Closed' || itemCase.Status == 'Closed - Duplicate'  ||  itemCase.Status == 'Merged' || itemCase.status == 'Closed - Follow Up' ){ 
                isClosed = true;
                break;
                // Skip closed cases

            }
            selectedCases.add(itemCase);
            
        }




    }
    

    public void submit() {
        // Contoh logika ketika user dipilih dan tombol submit ditekan
        System.debug('User yang dipilih: ' + selectedUserId);
        System.debug('Data Case' + ids);
        System.debug('cek string:' + String.isNotEmpty(selectedUserId));

        if(String.isNotBlank(selectedUserId)){
            isDisabled =true;
            List<String> listCase = ids.split(',');

            List<Case> cases = [Select Id, OwnerId  from Case where Id IN :listCase];

            for (Case c : cases) {
                c.OwnerId = selectedUserId;
            }
            update cases;
        
                isSuccess = true;
        

        }else{
            isEmpty = true;
        }

        
      
    }

    public void changeQueue() {
       List<Group> agentList = [
        SELECT Id, Name FROM Group WHERE Id IN (
            SELECT UserOrGroupId FROM GroupMember WHERE GroupId = :selectedQueueId
        ) 
        
        ];

        System.debug('AgentList Size:' + agentList.Size());
        List<Id> AgentIdList = new List<Id>();
        for(Group g : agentList){
        System.debug('Queue Name : '+ g.Name +' | ' +g.Id);
        agentIdList.add(g.Id);
        }
        List<User> users = [
        SELECT Id, Name from User where Id IN (
            SELECT UserOrGroupId FROM GroupMember WHERE GroupId IN :AgentIdList
        )
        ];
        System.debug('Users Size:' + users.size());
        userOptions = new List<SelectOption>();
        userOptions.add(new SelectOption('', '-- Select User --'));
        for (User u : users) {
            userOptions.add(new SelectOption(u.Id, u.Name));
        }
    }
}