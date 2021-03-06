

 <link href="${WEB_PATH}/resources/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
 <link href="${WEB_PATH}/resources/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
 <link href="${WEB_PATH}/resources/css/plugins/datapicker/datepicker3.css" rel="stylesheet">

	<style>
    	.company:after {
		    background-color: #F5F5F5;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px 0 4px 0;
		    color: #9DA0A4;
		    content: "车辆信息";
		    font-size: 12px;
		    font-weight: bold;
		    left: -1px;
		    padding: 3px 7px;
		    position: absolute;
		    top: -1px;
		}
		.company {
		    margin-left: 0px;
		    padding:40px 15px 0px;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px;
		    position: relative;
		    word-wrap: break-word;
		}
		.account:after {
		    background-color: #F5F5F5;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px 0 4px 0;
		    color: #9DA0A4;
		    content: "账户信息";
		    font-size: 12px;
		    font-weight: bold;
		    left: -1px;
		    padding: 3px 7px;
		    position: absolute;
		    top: -1px;
		}
		.account {
		    margin-left: 0px;
		    padding:40px 15px 0px;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px;
		    position: relative;
		    word-wrap: break-word;
		    margin-top: 10px;
		}
		 
    </style>
<div class="modal inmodal" id="userModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: block; padding-left: 6px;">
        <div class="modal-dialog" style="width: 85%;">
            <div class="modal-content animated bounceInRight">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-top: -20px;"><span aria-hidden="true" id="close-x">&times;</span><span class="sr-only" >关闭</span>
                    </button>
                    <h1 class="modal-title">车辆信息添加</h1>
                    <div class="modal-body" style="max-height:450px;overflow-y: auto;"> 
                        <form class="m-t" id="addTruckInfo">
	                        <div style="" class="company ui-sortable">
	                    		 <div class="row">
	                    		 	<div class="col-sm-4"> 
		                                <div class="form-group">
		                                    <label>车牌号：</label>
		                                    <input id="text" name="track_no" id="track_no" minlength="2" type="text"  class="form-control" placeholder="请输入车牌号">
		                                </div>
		                            </div>
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车辆类型：</label>
                                   			<select data-placeholder="请选择车辆类型..." class="chosen-select form-control" required="" id="trucktype_list" name="truckType.id">
								        		<#list trucktypeList as tt>
								        			<option value="${tt.id}">${tt.name}</option>
								        		</#list>
								    		</select>
		                            	</div>
		                           </div>
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车牌类型：</label>
		                                    <select data-placeholder="请选择车牌类型..." class="chosen-select form-control" required="" id="truckplate_list" name="truckPlate.id">
								        		<#list truckplateList as tp>
								        			<option value="${tp.id}">${tp.name}</option>
								        		</#list>
								    		</select>
		                                </div>
		                            </div> 
		                         </div>
		                         <div class="row">
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车辆长度(长度数字)：</label>
		                                    <input id="text" name="track_long" id="track_long" minlength="2" type="text"  class="form-control" placeholder="请输入车辆长度">
		                                </div>
		                            </div> 
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车辆载重(吨位数字)：</label>
		                                    <input id="text" name="capacity" id="capacity" minlength="2" type="text"  class="form-control" placeholder="请输入车辆载重">
		                                </div>
		                            </div> 
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车牌品牌：</label>
		                                    <select data-placeholder="请选择车辆品牌..." class="chosen-select form-control" required="" id="truckbrand_list" name="truckBrand.id">
								        		<#list truckbrandList as tb>
								        			<option value="${tb.id}">${tb.name}</option>
								        		</#list>
								    	</select>
		                                </div>
		                            </div>  
		                        </div>
		                        <div class="row">
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车辆识别代码：</label>
		                                    <input id="text" name="track_read_no" id="track_read_no" minlength="2" type="text"  class="form-control" placeholder="请输入车辆识别码">
		                                </div>
		                            </div> 		                            
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>发动机品牌：</label>
		                                    <select data-placeholder="请选择发动机品牌..." class="chosen-select form-control" required="" id="enginebrand_list" name="engineBrand.id">
								        		<#list enginebrandList as eb>
								        			<option value="${eb.id}">${eb.name}</option>
								        		</#list>
								    	</select>
		                                </div>
		                            </div>  
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>发动机编号：</label>
		                                    <input id="text" name="engine_no" id="engine_no" minlength="2" type="text"  class="form-control" placeholder="请输入发动机编号">
		                                </div>
		                            </div> 
		                        </div>
		                        <div class="row">
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>发动机马力：</label>
		                                    <input id="text" name="horsepower" id="horsepower" minlength="2" type="text"  class="form-control" placeholder="请输入发动机马力">
		                                </div>
		                            </div> 		
		                            <div class="col-sm-4">
		                                <div class="form-group"  id="data_1">
		                                    <label>上牌时间：</label>
		                                    <div class="input-group date">
                                				<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                				<input type="text" class="form-control" value="" placeholder="选择上牌时间" name="tag_time" id="tag_time">
                           					 </div>
		                                </div>
		                            </div>                             
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>所属商户：</label>
		                                    <select data-placeholder="请选择所属商户..." class="chosen-select form-control" required="" id="company_list" name="company.id">
								        		<#list companyList as com>
								        			<option value="${com.id}">${com.name}</option>
								        		</#list>
								    	</select>
		                                </div>
		                            </div>  
		                        </div>
		                        <div class="row">
		                            <div class="col-sm-4">
		                                <div class="form-group">
		                                    <label>车辆描述：</label>
		                                    <input id="text" name="description" id="description" minlength="2" type="text"  class="form-control" placeholder="请输入车辆描述">
		                                </div>
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
        <script src="${WEB_PATH}/resources/js/jquery.min.js?v=2.1.4"></script>
<script src="${WEB_PATH}/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script src="${WEB_PATH}/resources/js/plugins/cropper/cropper.min.js"></script>
<script src="${WEB_PATH}/resources/js/demo/form-advanced-demo.min.js"></script>
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
   		$("#trucktype_list").chosen();//车辆类型下拉框搜索
   		$("#truckplate_list").chosen();//车牌类型下拉框搜索
   		$("#truckbrand_list").chosen();//车辆品牌下拉框搜索
  		$("#enginebrand_list").chosen();//发动机品牌下拉框搜索
   		$("#company_list").chosen();//商户下拉框搜索
        $('#saveBut').click(function(){
        	 $("#addTruckInfo").validate({     
			 submitHandler: function(form) 
			   {  
			   	  $('#saveBut').attr("disabled",true);    
			      $.ajax({
					  type: 'POST',
					  url: '${WEB_PATH }/truck/systruck/save.do',  
					  data: $('#addTruckInfo').serialize(),
					  dataType: "json",
						 success:function(result){  
							if(result.success == true){
								$('#userModal').remove();
						    	swal("操作成功",  result.msg, "success");
						    	$("#exampleTableEvents").bootstrapTable('refresh');
							}else{
								swal("操作失败", result.msg, "error");
								$('#saveBut').attr("disabled",false);  
							}
						}
					});
			   }  
			 });
   			 var e = "<i class='fa fa-times-circle'></i> ";
        });
       //关闭层
       $('#close-but').click(function(){
       alert("aaaaaaaaaa");
       		$('#userModal').remove();
       }); 
       $('#close-x').click(function(){
       		$('#userModal').remove();
       }); 
  });   
  </script>   

