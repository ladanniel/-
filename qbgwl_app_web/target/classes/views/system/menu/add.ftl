<div class="modal inmodal" id="userModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: block; padding-left: 6px;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-top: -20px;"><span aria-hidden="true" id="close-x">&times;</span><span class="sr-only" >关闭</span>
                    </button>
                    <h1 class="modal-title">新增菜单</h1>
                    <form class="form-horizontal m-t" id="addMenuInfo">
                    <div class="modal-body"> 
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>菜单名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" minlength="2" type="text"  class="form-control"  required="" aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>菜单类型：</label>
                                <div class="col-sm-8">
                                    <input id="type" type="hidden" name="type" class="form-control"  value="${typeMap.type}">
                                    <input id="type_name" type="text" class="form-control" disabled="true" value="${typeMap.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">上级菜单：</label>
                                <div class="col-sm-8">
                                    <input id="parent_id" type="hidden" name="parent_id" class="form-control"  value="<#if menu??>${menu.id}<#else>-1</#if>">
                                    <input id="name" type="text" class="form-control" disabled="true" value="<#if menu??>${menu.name}<#else>顶级菜单</#if>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">资源地址：</label>
                                <div class="col-sm-8">
                                   <select data-placeholder="请选择资源地址..." class="chosen-select form-control" required="" id="resource_list" name="resource.id">
								        <#list resourceList as vo>
								        	<option value="${vo.id}">${vo.name}</option>
								        </#list>
								    </select>
								    
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">排序：</label>
                                <div class="col-sm-8">
                                   <input name="soft" type="number" class="form-control" value="1">
                                </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal" id="close-but">关闭</button>
                        <button type="submit" class="btn btn-primary" id="saveBut">保存</button>
                    </div>
                 	</form> 
                </div>
            </div>
        </div> 
    </div>
 <script>
 $.validator.setDefaults({
    highlight: function(e) {
        $(e).closest(".form-group").removeClass("has-success").addClass("has-error")
    },
    success: function(e) {
        e.closest(".form-group").removeClass("has-error").addClass("has-success")
    },
    errorElement: "span",
    errorPlacement: function(e, r) {
        e.appendTo(r.is(":radio") || r.is(":checkbox") ? r.parent().parent().parent() : r.parent())
    },
    errorClass: "help-block m-b-none",
    validClass: "help-block m-b-none"
}),
 $(function(){    
 	    $("#resource_list").chosen();
        //添加用户信息#commentForm
        $('#saveBut').click(function(){
        	 $("#addMenuInfo").validate({     
			 submitHandler: function(form) 
			   {  
			   	    $('#saveBut').attr("disabled",true);    
					$.yilinAjax({
				   	  	type:'POST',
				   	  	url:'${WEB_PATH }/system/menu/add.do',
				   	  	data:$('#addMenuInfo').serialize(),
	            		errorcallback:null,
	            		successcallback:success
			   	    });
			   }  
			 });
   			 var e = "<i class='fa fa-times-circle'></i> ";
        });
       //关闭层
       $('#close-but').click(function(){
       		$('#userModal').remove();
       }); 
       $('#close-x').click(function(){
       		$('#userModal').remove();
       }); 
       
       function success(result){  
		 	$('#userModal').remove();
			if(result.success == true){
				swal({
			        title: "操作成功",
			        text: "添加菜单信息成功。"
		    	})
		    	location.reload();
			}else{
				swal({
			        title: "操作失败",
			        text: "系统异常。"
		    	})
			}
	  }
  });   
  </script>   
