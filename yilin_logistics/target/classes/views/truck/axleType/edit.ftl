<div class="modal inmodal" id="userModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: block; padding-left: 6px;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-top: -20px;"><span aria-hidden="true" id="close-x">&times;</span><span class="sr-only" >关闭</span>
                    </button>
                    <h1 class="modal-title">编辑拖挂轮轴类型</h1>
                    <form class="form-horizontal m-t" id="editAxleTypefo">
                    <input name="id" type="hidden"  class="form-control" value="${axleType.id}" >
                    <div class="modal-body"> 
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>类型名称：</label>
                                <div class="col-sm-8">
                                    <input id="text" name="name" minlength="2" type="text"  class="form-control" required="" aria-required="true" value="${axleType.name}" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>类型首字母：</label>
                                <div class="col-sm-8">
                                    <input id="text" name="first_letter" minlength="1" type="text"  class="form-control" required="" aria-required="true" value="${axleType.first_letter}" >
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
 $(function(){
       $('#saveBut').click(function(){
        	 $("#editAxleTypefo").validate({     
			 submitHandler: function(form) 
			   {  
			   	  $('#saveBut').attr("disabled",true);    
				  $.yilinAjax({
				   	  	type:'POST',
				   	  	url:'${WEB_PATH }/truck/axleType/edit.do',
				   	  	data:$('#editAxleTypefo').serialize(),
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
			if(result.success == true){
				$('#userModal').remove();
				swal("", result.msg, "success");
		    	$("#exampleTableEvents").bootstrapTable('refresh');
			}else{
				$('#saveBut').attr("disabled",false);    
				swal({
			        title: "操作失败",
			        text: result.msg
		    	});
			}
	   }
  });   
  </script>   
