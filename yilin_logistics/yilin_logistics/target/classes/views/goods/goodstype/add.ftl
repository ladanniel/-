<div class="modal inmodal" id="userModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: block; padding-left: 6px;">
        <div class="modal-dialog"  style="width: 40%;">
            <div class="modal-content animated bounceInRight">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-top: -20px;"><span aria-hidden="true" id="close-x">&times;</span><span class="sr-only" >关闭</span>
                    </button>
                    <h1 class="modal-title">新增货物类型</h1>
                    <form class="form-horizontal m-t" id="addResourceInfo">
                    <input type="hidden" name="parent_name" />
                    <input type="hidden" name="leav" />
                    <div class="modal-body"> 
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>货物类型名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" minlength="2" type="text"  class="form-control"  required="" aria-required="true">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>所属货物类型：</label>
                                <div class="col-sm-8">
                                    <select id="select_id" class="form-control" name="prentId" required="" aria-required="true">
                                    	<#list list as goodsType >
                                    		<#assign preTemp = "" />
                                    		<#list 0..goodsType.level as i>
                                    			<#assign preTemp = "-"+preTemp />
                                    		</#list>
                                    		<#if !id?? >
                                    			<option value="${goodsType.id}"    >${preTemp+goodsType.name}</option>
                                    		<#else>
                                    			<option value="${goodsType.id}"   >${preTemp+goodsType.name}</option>
                                    		</#if>
                                    	</#list>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">备注：</label>
                                <div class="col-sm-8">
                                	<input type="text" name="descs" class="form-control"   >
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
});
 $(function(){   
     //添加用户信息#commentForm
        $('#saveBut').click(function(){
        	 $("#addResourceInfo").validate({     
			 submitHandler: function(form) 
			   {  
			   	  $('#saveBut').attr("disabled",true);    
			      $.ajax({
					  type: 'POST',
					  url: '${WEB_PATH }/goods/goodstype/add.do',  
					  data: $('#addResourceInfo').serialize(),
					  dataType: "json",
						 success:function(result){  
							if(result.success == true){
								$('#userModal').remove();
								swal("", result.msg, "success");
								setTimeout(function(){
									location.reload();
								},1000);
								
						    	//$("#resourceTableEvents").bootstrapTable('refresh');
							}else{
								$('#saveBut').attr("disabled",false);    
								swal({
							        title: "操作失败",
							        text: result.msg
						    	})
							}
						}
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
  });   
  </script>   
