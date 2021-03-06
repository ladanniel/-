<div class="modal inmodal" id="userModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: block; padding-left: 6px;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-top: -20px;"><span aria-hidden="true" id="close-x">&times;</span><span class="sr-only" >关闭</span>
                    </button>
                    <h6 class="modal-title">提现详情</h6></br>
                    <form class="form-horizontal m-t" id="form-cash">
                    <div class="modal-body"> 
                    		<div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>可提现余额：</label>
                                <div class="col-sm-8">
                                	<p class="form-control-static" style="color:red">
                                		¥&nbsp;<#if capitalAccount.avaiable == 0>0<#elseif capitalAccount.avaiable gt 0 && capitalAccount.avaiable lt 1 >${capitalAccount.avaiable?string('0.00')}<#else>${capitalAccount.avaiable?string(',###.00')}</#if>
                                	</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>选择银行卡：</label>
                                <div class="col-sm-8">
                                    <select class="form-control" name="bankcard" id="bankcard">
                                		<#if lstBankCard?size == 0>
                                			<option value="no">还未绑定银行卡</option>
                                		</#if>
										<#list lstBankCard as vo >
												<!--<option value="${vo.bankCard}">${vo.bankCard + "尾号" + vo.bankCard?substring(vo.bankCard?length - 4,vo.bankCard?length)}</option>-->
												<option value="${vo.id}">${vo.bankCard?substring(0,4) + "************" + vo.bankCard?substring(vo.bankCard?length - 4,vo.bankCard?length)}</option>
										</#list>
                                 </select> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span style="color: red;">*&nbsp;&nbsp;</span>提现金额：</label>
                                <div class="col-sm-8">
                                    <input id="money" name="money" type="number"  class="form-control"  required="" aria-required="true" maxlength="11">
                                </div>
                            </div>
                            <div class="form-group row">
						                                <label class="col-sm-3 control-label" style="text-align: right;"><span style="color: red;">*&nbsp;&nbsp;</span>支付密码：</label>
						                                <div class="col-sm-8">
						                                	<input id="payPassword" name="payPassword" type="password"  class="form-control"  required="" aria-required="true" style="width:260px" placeholder="支付密码" maxlength="18">
						                                </div>
						    </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal" id="close-but">关闭</button>
                        <button type="submit" class="btn btn-primary" id="saveBut">确定</button>
                    </div>
                 	</form> 
                 	<div class="alert alert-info big">
					        <div class="col-md-1">
					        </div>
		     	 		 	<h4>温馨提示</h4>
		     	 		 	<ol class="padding-left-20">
							  <li>提现时间为工作日9：00到17：00。</li>
							  <li>当日发起的提现，会在3个工作日后对该提现进行审核。</li>
							  <li>如有疑问请拨打客服电话联系客服。</li>
							</ol>
	     	 		 </div>
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
 		var e = "<i class='fa fa-times-circle'></i> ";
        	 $("#form-cash").validate({
        	 	rules: {
		        	money: {
		                required: !0,
		                number: !0,
		            },
		            bankcard: {
		            	required: !0,
		            },
		            payPassword: {
		                required: !0,
		                rangelength: [6, 6],
		                isDigits: !0
		            }
		        },
		        messages: {
		            money: {
		                required: e + "请输入提现金额。",
		                number: e + "请输入正确的充值金额。",
		            },
		            payPassword: {
		                required: e + "请输入您的密码",
		                rangelength: e + "支付密码必须为6位数字。",
		            }
		        }
		});
        $('#saveBut').click(function(){
			 	if($("#form-cash").valid()){ 
			   	  $('#saveBut').attr("disabled",true); 
			   	   $.ajax({
					  type: 'POST',
					  url:'${WEB_PATH }/capital/cashapplication/add.do',  
					  data: $('#form-cash').serialize(),
					  dataType: "json",
					  success:function(result){  
							if(result.success == true){
								var avaiable = $("#avaiable").html();
								var money = $("#money").val();
								var frozen = $("#frozen").html();
								$("#avaiable").html(Number(avaiable) - Number(money));
								$("#frozen").html(Number(frozen) + Number(money));
								$('#userModal').remove();
								swal("", result.msg, "success");
							    $("#exampleTableEvents").bootstrapTable('refresh');
							}
						},
						error:function(data){
						 	$('#saveBut').attr("disabled",false); 
						 	var data = $.parseJSON(data.responseText);
					        swal("", data.msg, "error");
						 }
					});
        	 }
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
