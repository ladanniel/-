<!DOCTYPE html>
<html> 
<head> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>资金账户</title> 
    <link rel="shortcut icon" href="favicon.ico">
	<#import "/common/import.ftl" as import>
    <@import.tableManagerImportCss/> 
    <link href="${WEB_PATH}/resources/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
    <style>
    	.demo:after {
		    background-color: #F5F5F5;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px 0 4px 0;
		    color: #9DA0A4;
		    content: "条件查询：";
		    font-size: 12px;
		    font-weight: bold;
		    left: -1px;
		    padding: 3px 7px;
		    position: absolute;
		    top: -1px;
		}
		.demo {
		    margin-left: 0px;
		    padding:40px 15px 0px;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px;
		    position: relative;
		    word-wrap: break-word;
		}
		
		.demo1:after {
		    background-color: #F5F5F5;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px 0 4px 0;
		    color: #9DA0A4;
		    content: "帐户资金信息：";
		    font-size: 12px;
		    font-weight: bold;
		    left: -1px;
		    padding: 3px 7px;
		    position: absolute;
		    top: -1px;
		}
		.demo1 {
		    margin-left: 0px;
		    padding:40px 15px 0px;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px;
		    position: relative;
		    word-wrap: break-word;
		}
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        

        <!-- Panel Other -->
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>资金账户 - 资金流水详情</h5>
                <div class="ibox-tools"> 
                    
                </div>
            </div>
            <div class="ibox-content">
                <div class="row row-lg">  
                    <div class="col-sm-12">
                        <!-- Example Events -->
                        <div class="example-wrap"> 
                        	<div style="" class="demo1 ui-sortable">
				                            		 <div class="row">
							                            <div class="form-group" style="font-size: 18px;">
						                    				<div class="col-sm-4">&nbsp;
						                    				</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						                            			总资产：<span style="color:red">¥&nbsp;<font id="total">${account.total}</font></span> =
                                    							可用余额：<span style="color:red">¥&nbsp;<font id="avaiable">${account.avaiable}</font></span> +
                                    							冻结资金：<span style="color:red">¥&nbsp;<font id="frozen">${account.frozen}</font></span>
                                    					</div>
							                        </div>
							</div>
                            <div style="" class="demo ui-sortable">
				                            		 <div class="row">
							                            <div class="col-sm-4 row" style="margin-left:5px;">
							                                <label>交易时间范围：</label>
							                                <div id="data">
							                                    <div class="input-daterange input-group" id="datepicker">
									                                <input type="text" class="input-sm form-control" name="ostart" id="start" value="" placeholder="选择开始时间"/>
									                                <span class="input-group-addon">到</span>
									                                <input type="text" class="input-sm form-control" name="oend" id="end" value="" placeholder="选择结束时间"/>
									                            </div>
							                                </div>
							                            </div>
							                            <div class="col-sm-3">
							                                <div class="form-group">
							                                    <label>类型：</label>
							                                    <select class="form-control" name="sstatus" id="sstatus" placeholder="全部">
							                                    	  <option value="">全部</option>
										                              <option value="recharge">充值</option> 
										                              <option value="frozen">冻结</option>
										                              <option value="cash">提现</option>
										                              <option value="transfer">转账</option>
										                              <option value="fee">手续费</option>
										                              <option value="consume">消费</option>
										                              <option value="income">收款</option>
										                              <option value="other">其它</option>
															 	</select>
							                                </div>
							                            </div>
							                             
							                        </div>
							                    </div>
							                    </div>
						                            <div class="btn-group" id="exampleTableEventsToolbar" role="group">
					                                    <button type="button" class="btn btn-outline btn-default" data-toggle="modal" id="recharge" >
					                                        <i class="glyphicon glyphicon-floppy-open" aria-hidden="true"></i>&nbsp;&nbsp;充值
					                                    </button>
					                                    <button type="button" class="btn btn-outline btn-default" data-toggle="modal" id="cash" >
					                                        <i class="glyphicon glyphicon-floppy-save" aria-hidden="true"></i>&nbsp;&nbsp;提现
					                                    </button>
					                                    <button type="button" class="btn btn-outline btn-default" data-toggle="modal" id="transfer" >
					                                        <i class="glyphicon glyphicon-transfer" aria-hidden="true"></i>&nbsp;&nbsp;转账
					                                    </button>
					                                    <button type="button" class="btn btn-outline btn-default" data-toggle="modal" id="look-but" >
					                                        <i class="fa fa-file-text-o" aria-hidden="true"></i>&nbsp;&nbsp;查看记录
					                                    </button>
					                                </div>
						                    </div>
                                <table id="exampleTableEvents" data-height="520" data-mobile-responsive="true" >
                                    <thead>
                                        <tr>
                                        	<th data-field="state" data-radio="true"></th>  
		                                    <th data-field="id"  data-visible="false" >id</th>
								            <th data-field="sourceType" >交易方式类型</th> 
								            <th data-field="tradeName" >交易来源名称（银行或支付平台）</th>
                                        	<th data-field="tradeAccount" >交易来源账号（卡号或支付账号）</th> 
                                        	<th data-field="type"  data-formatter="formatType">类型</th>
                                        	<th data-field="money" >交易金额</th>
								            <th data-field="create_time" data-formatter="formatTime">交易时间</th>
								            <th data-field="remark" data-visible="false">备注</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <!-- End Example Events -->
                    </div>
                </div>
            </div>
        </div>
        <!-- End Panel Other -->
    </div>
    <div id="win_add"></div>
    <div id="cash-div"></div>
	<div id="recharge-div"></div> 
	<div id="transfer-div"></div>
    <@import.tableManagerImportScript/> 
    <script src="${WEB_PATH}/resources/js/plugins/layer/layer.js"></script>
    <script src="${WEB_PATH}/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="${WEB_PATH}/resources/js/plugins/switchery/switchery.js"></script>
    <script >
    	$("#data .input-daterange").datepicker({
	        keyboardNavigation: !1,
	        forceParse: !1,
	        autoclose: !0
	    }); {
	        var i = document.querySelector(".js-switch"),
	        t = (new Switchery(i, {
	            color: "#1AB394"
	        }), document.querySelector(".js-switch_2")),
	        a = (new Switchery(t, {
	            color: "#ED5565"
	        }), document.querySelector(".js-switch_3"));
	        new Switchery(a, {
	            color: "#1AB394"
	        })
	    } 
	    $("#start").change(function(){
	    	var end = $("#end").val();
	    	var start = $("#start").val();
	    	if(end == null || "" == end){
	    		$("#end").val(start);
	    	}else{
	    		var end1 = end.replace("-","");
	    		var start1 = start.replace("-","");
	    		if(end1 < start1){
	    			$("#end").val(start);
	    		}
	    	}
	    });
	    $("#end").change(function(){
	    	var end = $("#end").val();
	    	var start = $("#start").val();
	    	if(start == null || "" == start){
	    		$("#start").val(end);
	    	}else{
	    		var end1 = end.replace("-","");
	    		var start1 = start.replace("-","");
	    		if(end1 < start1){
	    			$("#start").val(end);
	    		}
	    	}
	    });
    	function queryParams(params) {
	        var temp = {  
		        limit: params.limit,  
		        offset: params.offset, 
		        start: $("#start").val(),
		        end: $("#end").val(),
		        search: $("input.form-control.input-outline").val(),
		        type: $("#sstatus option:selected").val(),
		        maxrows: params.limit,
		        pageindex:params.pageNumber,
	        };
	        return temp;
		}
    	//加载用户table数据
    	$(function(){ 
	    	$("#exampleTableEvents").bootstrapTable({
	            url: "${WEB_PATH }/capital/account/getPage.do",
	            method: 'get',
	            search:true,
	            pagination:true,
	            pageNumber:1,  
	            pageSize:10,   
	            showRefresh:true, 
	            showColumns:true,
	            iconSize: "outline",
	            toolbar: "#exampleTableEventsToolbar",
	            sidePagination: "server", //设置为服务器端分页
	            queryParams: queryParams,//参数
	            searchText:"",   //设置搜索框文本初始值
	            minimumCountColumns: 1,  
	            showToggle:false, 
	            clickToSelect: true,  
	            icons: {
	                refresh: "glyphicon-repeat", 
	                columns: "glyphicon-list"
	            }
	        });
	        $('input.form-control.input-outline').attr("placeholder","输入交易来源名称搜索");
        });
        
        //查看交易记录
        $('#look-but').click(function(){
        	var selectRow = $("#exampleTableEvents").bootstrapTable('getSelections');
        	var info = selectRow[0]; 
	        if(1 != selectRow.length){
			    layer.msg('<font color="red">温馨提示：请选择一条交易记录查看。</font>', {icon: 5}); 
			    return ;
	       	}
	       	$("#win_add").load("${WEB_PATH }/capital/traderecord/view/look.do?id="+info.id);
        });
        
        //选择刷新
		$("#sstatus").change(function(){
			$("#exampleTableEvents").bootstrapTable('refresh');
		});
        
        //导出Excel
        $("#export-but").click(function(){
        	alert("导出excel表格。");
        });
        
        function formatStatus(val){
			if(val == 'failed'){
				return '<span class="label label-danger">失败</span>';
			}else if(val == 'success'){
				return '<span class="label label-success">成功</span>';
			}else{
				return '<span class="label label-default">待处理</span>';
			}
			
		}
		function formatTime(val){
		 	var tt=new Date(val).toLocaleString(); 
    		return tt; 
		}
		
		function formatType(val){
			if(val == 'recharge'){
				return '<span class="label label-primary">充值</span>';
			}else if(val == 'frozen'){
				return '<span class="label">冻结</span>';
			}else if(val == 'cash'){
				return '<span class="label label-danger">提现</span>';
			}else if(val == 'transfer'){
				return '<span class="label label-danger">转账</span>';
			}else if(val == 'fee'){
				return '<span class="label label-danger">手续费</span>';
			}else if(val == 'consume'){
				return '<span class="label label-danger">消费</span>';
			}else if(val == 'income'){
				return '<span class="label label-primary">收款</span>';
			}else{
				return '<span class="label">其它</span>';
			}
		}
		
		$('#recharge').click(function(){
			$("#recharge-div").load("${WEB_PATH }/capital/rechargerecord/view/add.do");
		});  
		$('#cash').click(function(){
			$("#cash-div").load("${WEB_PATH }/capital/cashapplication/view/add.do");
		});  
		$('#transfer').click(function(){
			$("#transfer-div").load("${WEB_PATH }/capital/transfer/view/add.do");
		});
    </script>
</body>

</html>