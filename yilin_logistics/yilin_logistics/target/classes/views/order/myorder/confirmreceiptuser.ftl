<!DOCTYPE html>
<html> 
<head> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>货物信息</title> 
    <link rel="shortcut icon" href="favicon.ico">
	<#import "/common/import.ftl" as import>
    <@import.tableManagerImportCss/> 
    <link href="${WEB_PATH}/resources/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
    <link href="${WEB_PATH}/resources/js/plugins/ystep/css/ystep.css" rel="stylesheet">
    <link href="${WEB_PATH}/resources/js/plugins/ystep/css/op_express.css" rel="stylesheet">

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
    	.goods:after {
		    background-color: #F5F5F5;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px 0 4px 0;
		    color: #9DA0A4;
		    content: "货物详细信息";
		    font-size: 12px;
		    font-weight: bold;
		    left: -1px;
		    padding: 3px 7px;
		    position: absolute;
		    top: -1px;
		}
		.goods {
		    margin-left: 0px;
		    padding:40px 15px 0px;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px;
		    position: relative;
		    word-wrap: break-word;
		    margin-top: 10px;
		}
    
    	.consignor:after {
		    background-color: #F5F5F5;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px 0 4px 0;
		    color: #9DA0A4;
		    content: "联系人信息";
		    font-size: 12px;
		    font-weight: bold;
		    left: -1px;
		    padding: 3px 7px;
		    position: absolute;
		    top: -1px;
		}
		.consignor {
		    margin-left: 0px;
		    padding:40px 15px 0px;
		    border: 1px solid #DDDDDD;
		    border-radius: 4px;
		    position: relative;
		    word-wrap: break-word;
		    margin-top: 10px;
		}
    </style>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">

        <!-- Panel Other -->
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>回执处理</h5>
                <div class="ibox-tools"> 
                </div>
            </div>
            <div class="ibox-content">
                <div class="row row-lg">  
                    <div class="col-sm-12">
                        <div class="example-wrap"> 
                        		<div style="" class="demo ui-sortable">
                            		 <div class="row" style="margin-bottom: 10px;"> 
				                          <div class="col-sm-4"> 
				                                <div class="form-group">
				                                    <label>快递公司：</label>
				                                    <select data-placeholder="请选择快递公司" id="code" class="chosen-select form-control">
				                                    	<option value="-1" hassubinfo="true" ></option>
				                                    	<#list lgisticsList as info>
				                                    		<option value="${info.code}" hassubinfo="true" >${info.name}</option>
				                                    	</#list>
					                                </select>
				                                </div>
				                            </div>
			                            <div class="col-sm-4">
			                               <div class="form-group">
			                                    <label>快递单号：</label>
			                                    <input id="num" name="num" class="form-control"  type="text" value="">
			                                </div>
			                            </div> 
			                            <div class="col-sm-4" style="padding-top: 22px;">
			                                 <button type="button" class="btn btn-primary" id="search"><i class="fa fa-search"></i>&nbsp;&nbsp;查询</button>
			                            </div> 
			                        </div>
			                    </div>
                                <table id="exampleTableEvents"  data-mobile-responsive="true" >
                                    <thead>
                                        <tr>
		                                    <th data-field="id"  data-visible="false" >id</th>
		                                    <th data-field="robOrderNo">订单号</th>
								            <th data-field="deliveryAreaName" data-formatter="formatAreaName">路线(出发地/目的地)</th>
								            <th data-field="goodsType" data-formatter="formatGoodsType">货物类型</th>
								            <th data-field="unitPrice" data-formatter="formatUnitPrice">单价</th>
								            <th data-field="weight" data-formatter="formatWeight">总重量/吨</th>
								            <th data-field="totalPrice" data-formatter="formatTotalPrice">总价（总重量*单价）</th>
								            <th data-field="depositUnitPrice" data-formatter="formatDeposit">运输押金总金额</th>
								            <!--<th data-field="status" data-formatter="formatStatus">状态</th>-->
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Panel Other -->
    </div>
    <div id="win_add"></div>
    <@import.tableManagerImportScript/> 
    <script src="${WEB_PATH}/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="${WEB_PATH}/resources/js/plugins/switchery/switchery.js"></script>
	<script src="${WEB_PATH}/resources/js/plugins/ystep/js/ystep.js"></script> 
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=1AC8RPrl58FNLoYjoEhOiwv8SsgToWRm"></script>
    <script >
    	function queryParams(params) {
	        var temp = {  
		        limit: params.limit,  
		        offset: params.offset, 
		        lgisticsCode: $("#code").val(),
		        lgisticsNum: $("#num").val(),
		        maxrows: params.limit,
		        pageindex:params.pageNumber,
	        };
	        return temp;
		}
    	//加载用户table数据
    	$(function(){ 
    		
    		layer.config({
				extend: 'extend/layer.ext.js'
			});  
    		$("#goodsType_id").chosen({width:'100%'}); 
    		$("#code").chosen({width:'100%'}); 
    		$(window).resize(function () {
		        $('#exampleTableEvents').bootstrapTable('resetView');
			});
	    	$("#exampleTableEvents").bootstrapTable({
	            url: "${WEB_PATH }/order/myorder/confirmreceiptuser.do",
	            method: 'get',
	            search:false,
	            pagination:false,
	            pageNumber:1,  
	            pageSize:10,   
	            showRefresh:true, 
	            showColumns:true,
	            detailView:true,
	            //detailFormatter:detailFormatter, 
	            onClickRow:onClickContacts,
	            iconSize: "outline",
	            toolbar: "#exampleTableEventsToolbar",
	            sidePagination: "server", //设置为服务器端分页
	            queryParams: queryParams,//参数
	            minimumCountColumns: 1, 
	           // clickToSelect: true, 
	            onExpandRow:subTableFormatter
	        }); 
	         //点击查询搜索
			$("#search").click(function(){
				var code = $("#code").val();
				if(code==""){
				    layer.tips("请选择快递公司", '#code_chosen'); 
					return false;
				}
				
				var num = $("#num").val();
				if(num==""){
					layer.tips("请输入快递单号", '#num'); 
					return false;
				}
			
				$("#exampleTableEvents").bootstrapTable('refresh');
			});
	        $('input.form-control.input-outline').attr("placeholder","请输入收获地址");
        });
        
        
        $('#rob-cancel').click(function(){
        	  var selectRow = $("#exampleTableEvents").bootstrapTable('getSelections');
        	  var info = selectRow[0]; 
	          if(1 != selectRow.length){
			    layer.msg('<font color="red">温馨提示：请选择一条抢单信息，进行取消！</font>', {icon: 5}); 
			    return ;
	       	  }
	          layer.prompt({title: '请填写取消原因（必须填写）', formType: 2}, function(value, index, elem){
			  		saveRobOrderCancel(info.id,value,index);
			  }); 
        });
        
        $("#translate-but").click(function(){
        	var selectRow = $("#exampleTableEvents").bootstrapTable('getSelections');
        	var info = selectRow[0]; 
	        if(1 != selectRow.length){
			    layer.msg('<font color="red">温馨提示：请选择一条抢单信息，进行撤回！</font>', {icon: 5}); 
			    return ;
	       	}
        	layer.confirm('尊敬的用户您好：<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red">您确定把当前抢单信息撤回吗？</span>',{icon: 3, title:'抢单撤回信息提示',btn: ['确定','取消']},
    		function(){
    			  $.yilinAjax({
			   	  	 type:'POST',
			   	  	 url:'${WEB_PATH }/order/roborder/withdrawRobOrder.do?id='+ info.id, 
			   	  	 data:null,
            		 errorcallback:null,
            		 successcallback:successTranslate
			   	  });
			}, function(){
				  layer.closeAll();
			});
        });
        
        $('#confirm-but').click(function(){
        	var selectRow = $("#exampleTableEvents").bootstrapTable('getSelections');
        	var info = selectRow[0]; 
	        if(1 != selectRow.length){
			    layer.msg('<font color="red">温馨提示：请选择一条抢单信息，进行确认！</font>', {icon: 5}); 
			    return ;
	       	} 
		    layer.open({
		      type: 2,
		      title: '<span style="color: #ed5565"><i class="fa fa-pencil"></i>&nbsp;&nbsp;抢单信息确认</span>',
		      shadeClose: true,
		      shade: false,
		      maxmin: false, //开启最大化最小化按钮
		      area: ['88%', '88%'],
		      content: '${WEB_PATH }/order/roborder/confirmroborder.do?id='+info.id,
		      btn: ['<i class="fa fa-check"></i>&nbsp;确认','取消'],
		      yes: function(index, layero){
			      var body = layer.getChildFrame('body', index);
			      var iframeWin = window[layero.find('iframe')[0]['name']];
			      iframeWin.confirmRobOrder();
			  }, 
			  cancel: function(){  
					layer.open({
					  content: '<font color="#ed5565;">您可能有填写的信息未保存，确定关闭当前窗口吗？</font>',
					  icon: 2,
					  btn: ['确定', '取消'],
					  yes: function(index, layero){
					    	layer.closeAll();
					  } 
					});
					return false;
			  } 
		    });
        });
        
        $('#edit-but').click(function(){
        	var selectRow = $("#exampleTableEvents").bootstrapTable('getSelections');
        	var info = selectRow[0]; 
	        if(1 != selectRow.length){
			    layer.msg('<font color="red">温馨提示：请选择一条抢单信息，进行编辑！</font>', {icon: 5}); 
			    return ;
	       	}
	       	 
		    layer.open({
		      type: 2,
		      title: '<span style="color: #ed5565"><i class="fa fa-pencil"></i>&nbsp;&nbsp;抢单信息修改</span>',
		      shadeClose: true,
		      shade: false,
		      maxmin: false, //开启最大化最小化按钮
		      area: ['88%', '88%'],
		      content: '${WEB_PATH }/order/roborder/editroborder.do?id='+info.id,
		      btn: ['<i class="fa fa-hand-rock-o"></i>&nbsp;提交','取消'],
		      yes: function(index, layero){
			      var body = layer.getChildFrame('body', index);
			      var iframeWin = window[layero.find('iframe')[0]['name']];
			      iframeWin.updateRobOrder();
			  }, 
			  cancel: function(){  
					layer.open({
					  content: '<font color="#ed5565;">您可能有填写的信息未保存，确定关闭当前窗口吗？</font>',
					  icon: 2,
					  btn: ['确定', '取消'],
					  yes: function(index, layero){
					    	layer.closeAll();
					  } 
					});
					return false;
			  } 
		    });
        });
        
        function onClickContacts(index, row, element){
			if(index.status == 'apply'){
				$("#edit-but").attr("disabled",true); 
		 	 	$("#translate-but").attr("disabled",false); 
		 	 	$("#rob-cancel").attr("disabled",false); 
		 	 	$("#confirm-but").attr("disabled",true); 
			}else if(index.status == "withdraw"){
				$("#edit-but").attr("disabled",false); 
		 	 	$("#translate-but").attr("disabled",true); 
		 	 	$("#rob-cancel").attr("disabled",false); 
		 	 	$("#confirm-but").attr("disabled",true); 
			}else if(index.status == "back"){
				$("#edit-but").attr("disabled",false); 
		 	 	$("#translate-but").attr("disabled",true); 
		 	 	$("#rob-cancel").attr("disabled",false); 
		 	 	$("#confirm-but").attr("disabled",true); 
			}else if(index.status == "success"){
				$("#edit-but").attr("disabled",true); 
		 	 	$("#translate-but").attr("disabled",true); 
		 	 	$("#rob-cancel").attr("disabled",false); 
		 	 	$("#confirm-but").attr("disabled",false); 
			}else if(index.status == "dealing"){
				$("#edit-but").attr("disabled",true); 
		 	 	$("#translate-but").attr("disabled",true); 
		 	 	$("#rob-cancel").attr("disabled",true); 
		 	 	$("#confirm-but").attr("disabled",true); 
			} 
		}
        
        function successTranslate(result) {
			layer.closeAll();
			if(result.success == true){
				swal("撤回成功！", result.msg, "success");
				$("#exampleTableEvents").bootstrapTable('refresh');
			}else{
				swal("撤回失败！", result.msg, "error");
				$("#exampleTableEvents").bootstrapTable('refresh');
			}
		}
        
        var prompt = null;
        function  saveRobOrderCancel(id,text,index){
        	prompt = index;
			$.yilinAjax({
			  	 type:'POST',
			  	 loadmsg:'取消中......',
			  	 url:'${WEB_PATH }/order/roborder/saveRobOrderCancel.do',
			  	 data:{id:id,cancelRemark:text},
				 errorcallback:null,
				 btn:null,
				 successcallback:success
			});
        }
        
        function success(result){  
			layer.closeAll(); 
			if(result.success == true){
				layer.close(prompt); 
		    	layer.msg(result.msg, {icon: 1}); 
		    	$("#exampleTableEvents").bootstrapTable('refresh');
			}else{
				layer.close(prompt); 
				layer.msg('<font color="red">'+result.msg+'</font>', {icon: 5}); 
			}
		} 
		
		function subTableFormatter(index, row, $detail){
			// var cur_table = $detail.html('<table></table>').find('table');
			 
			 var cur_table = $detail.html('<div><div id="info"></div><table></table></div>').find('table');
			 var div = $detail.find('#info').load("${WEB_PATH}/order/myorder/getgoodsinfo.do?id="+row.id);
			  
			 $(cur_table).bootstrapTable({
		            url: "${WEB_PATH }/order/myorder/getTruckPage.do",
		            method: 'get',
		            queryParams:function(params){
		              var temp = {  
					        limit: params.limit,  
					        offset: params.offset,
					        maxrows: params.limit,
					        pageindex:params.pageNumber,
					        robOrderId: row.id,
					        lgisticsCode: $("#code").val(),
		       				lgisticsNum: $("#num").val()
				        };
				        return temp;
		            },
		           // queryParams: { robOrderId: row.id},
		            clickToSelect: true,
		            detailView: true,//父子表
		            uniqueId: "robOrderId",
		            pagination:false,
	                pageNumber:1,  
	                pageSize:10,   
		            sidePagination: "server", //设置为服务器端分页
		            pageSize: 10,
		            pageList: [10, 25],
		            onExpandRow:subTableFormatter_1,
		            columns: [{
		                field: 'transportNo',
		                title: '运输单号'
		            },{
		                field: 'turckUserName',
		                title: '司机'
		            }, {
		                field: 'phone',
		                title: '司机号码'
		            }, {
		                field: 'trackNo',
		                title: '车牌号'
		            }, {
		                field: 'cardType',
		                title: '车辆类型'
		            },{
		                field: 'unitPrice',
		                title: '单价',
		                formatter:function(val){
		                	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		                	
		                }
		            },{
		                field: 'totalWeight',
		                title: '总重量/吨',
		                formatter:function(val){
		                	return '<font class="text-danger">'+val+' (吨)</font>';
		                	
		                }
		            },{
		                field: 'transportationCost',
		                title: '总价',
		                formatter:function(val){
		                	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		                	
		                }
		            },{
		                field: 'transportationDeposit',
		                title: '运输押金总金额',
		                formatter:function(val){
		                	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		                	
		                }
		            },{
		                field: 'turckCost',
		                title: '车辆押金总金额',
		                formatter:function(val){
		                	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		                	
		                }
		            },{
		                field: 'status',
		                title: '状态',
		                formatter:function(val){
		                	if(val == 0){
								return '<span class="label label-default">待装货</span>';
							}else if(val == "1"){
								return '<span class="label label-primary">确认装货</span>';
							}else if(val == "2"){
								return '<span class="label label-primary">运输中</span>';
							}else if(val == "3"){
								return '<span class="label label-warning">送达</span>';
							}else if(val == "4"){
								return '<span class="label label-success">回执发还中</span>';
							}else if(val == "5"){
								return '<span class="label label-danger">送还回执中</span>';
							}else if(val == "6"){
								return '<span class="label label-primary">订单完结</span>';
							}else if(val == "7"){
								return '<span class="label la label-danger">已销单</span>';
							}
		                }
		            },{
		                title: '操作',
		                events: operateEvents,
		                formatter:function(val,row,index){
		                	if(row.status == "4"){
		                	  	return '<button class="btn btn-info btn-sm btn_user" sytle="border-radius: 3px;" type="button" id=""><i class="fa fa-user"></i> 人员分配</button>';
		                	}
		                	return '';
		                }
		            }]
	          });
		}
		
		
		    window.operateEvents = {
		        'click .like': function (e, value, row) {
		            alert('You click like action, row: ' + JSON.stringify(row));
		        },
		        'click .btn_user': function (e, value, row) {
				   layer.open({
				      type: 2,
				      title: '<span style="color: #ed5565"><i class="fa fa-pencil"></i>&nbsp;&nbsp;人员分配</span>',
				      shadeClose: true,
				      shade: false,
				      maxmin: false, //开启最大化最小化按钮
				      area: ['100%', '100%'],
				      content: '${WEB_PATH }/order/myorder/view/receiptuser.do?robOrderId='+row.robOrderId+'&robConfirmId='+row.robConfirmId,
				      cancel: function(){ 
						    layer.open({
								  content: '<font color="#ed5565;">您可能有填写的信息未保存，确定关闭当前窗口吗？</font>',
								  icon: 2,
								  btn: ['确定', '取消'],
								  yes: function(index, layero){
								    	layer.closeAll();
								  } 
							});
							return false;
					  }
				    });
		        }
		    };
		

		
		function subTableFormatter_1(index, row, $detail){
			 // var cur_table = $detail.html('<div><div id="info"></div><table></table></div>').find('table');
			 // var div = $detail.find('#info').load("${WEB_PATH}/order/myorder/getgoodsinfo.do?id="+row.robOrderId);
			  var cur_table = $detail.html($("#body").html()).find('table');
			  
			   $.yilinAjax({
		   	  	type:'GET',
		   	  	async:false,
		   	  	loadmsg:'订单确认中......',
		   	  	url:'${WEB_PATH }/order/myorder/orderstatus.do?robConfirmId='+row.robConfirmId,
		   	  	btn:null,
        		errorcallback:null,
        		successcallback:function(r){
        		console.log(r);
        			$ystep =  $detail.find(".ystep1").loadStep({
				      //ystep的外观大小
				      //可选值：small,large
				      size: "large",
				      //ystep配色方案
				      //可选值：green,blue
				       color: "green",
				      //ystep中包含的步骤
				      steps: r.list
			   		 });	
			   		 
			   		  $detail.find(".ystep1").setStep(r.index);
				    //alert($('#panel-body').width());
				    $detail.find(".ystep-green").width($detail.find(".ystep1").width());
        		}
		   	 });
			  
			  $(cur_table).bootstrapTable({
		            url: "${WEB_PATH }/order/myorder/getOrderInfoPage.do",
		            method: 'get',
		            queryParams:function(params){
		              var temp = {  
					        limit: params.limit,  
					        offset: params.offset,
					        maxrows: params.limit,
					        pageindex:params.pageNumber,
					        robOrderId: row.robOrderId,
					        truckID: row.turckID,
				        };
				        return temp;
		            },
		           // queryParams: { robOrderId: row.id},
		            clickToSelect: true,
		            detailView: false,//父子表
		            uniqueId: "robOrderId",
		            pagination:false,
	                pageNumber:1,  
	                pageSize:10,   
		            sidePagination: "server", //设置为服务器端分页
		            pageSize: 10,
		            pageList: [10, 25],
		            columns: [{
		                field: 'goodName',
		                title: '货物名称'
		            }, {
		                field: 'goodTypeName',
		                title: '货物类型'
		            }, {
		                field: 'unitPrice',
		                title: '单价',
		                formatter:function(val){
		                	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		                	
		                }
		            }, {
		                field: 'weight',
		                title: '重量',
		                formatter:function(val){
		                 	return '<font class="text-danger">'+val+'&nbsp;(吨)</font>';
		                }
		            }, {
		                field: 'totalPrice',
		                title: '单货总价',
		                formatter:function(val){
		                	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		                }
		            }]
	          });
		}
		
		function subTableQueryParams(params) {
	        var temp = {  
		        limit: params.limit,  
		        offset: params.offset,
		        maxrows: params.limit,
		        pageindex:params.pageNumber,
	        };
	        return temp;
		}
		
        function detailFormatter(index, row) {
        	//加载层-风格4
        	var html = ""; 
        	$.ajax({
	            url:"${WEB_PATH}/order/roborder/getRobOrderInfo.do?id="+row.id,
	            type:'get',
	            dataType:'html',
	            cache:false, 
 				async:false, 
	            success:function(data){
	                 html = data
	            }
	        });
		    return html;
		}
		
		function formatTime(val){
		 	var tt=new Date(val).toLocaleString(); 
    		return tt; 
		}
		
		function formatAreaName(index, row, element){
		 	var tt =  '<span class="label label-primary">'+row.deliveryAreaName+'</span>&nbsp;&nbsp;------->&nbsp;&nbsp;<span class="label label-danger">'+row.consigneeAreaName+'</span>';
    		return tt; 
		}
		
		function formatFiniteTime(index, row, element){
			var tt = "";
			if(row.longTime){
				tt = '<span class="label label-danger"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;长期有效</span>'
			}else{
			    tt=new Date(row.finiteTime).toLocaleString(); 
			}
    		return tt; 
		}
		
		
	 	function formatGoosUnitPrice(index, row, element){
	 		return '¥&nbsp;'+row.goodsBasic.unitPrice;
	 	}
	 	function formatUnitPrice(val){
		 	return '<font class="text-danger">¥&nbsp;'+val+'</font>';
		}
		function formatGoodsTotalPrice(index, row, element){
	 		return '¥&nbsp;'+row.goodsBasic.totalPrice;
	 	}
		function formatTotalPrice(val){
	 		return '<font class="text-danger">¥&nbsp;'+val+'</font>';
	 	}
	 	function formatDeposit(value,row,index){
		    var deposit = row.weight*value;
	 		return '<font class="text-danger">¥&nbsp;'+deposit.toFixed(2)+'</font>';
	 	}
	 	function formatTotalWeight(index, row, element){
	 		return row.goodsBasic.totalWeight+"&nbsp;(吨)";
	 	}
	 	function formatWeight(val){
	 		return '<font class="text-danger">'+val+'&nbsp;(吨)</font>';
	 	}
	 	function formatGoodsType(index, row, element){
    		return row.goodType; 
		}
		function formatStatus(val){
			if(val == '0'){
				return '<span class="label label-default">待装货</span>';
			}else if(val == "1"){
				return '<span class="label label-primary">确认装货</span>';
			}else if(val == "2"){
				return '<span class="label label-primary">运输中</span>';
			}else if(val == "3"){
				return '<span class="label label-warning">送达</span>';
			}else if(val == "4"){
				return '<span class="label label-success">回执发还中</span>';
			}else if(val == "5"){
				return '<span class="label label-danger">送还回执中</span>';
			}else if(val == "6"){
				return '<span class="label label-primary">订单完结</span>';
			}else if(val == "7"){
				return '<span class="label la label-danger">已销单</span>';
			}
		}
    </script>
    <div id="body" class="hidden">
	      <div class="col-sm-12">
	         <div class="panel panel-primary">
	             <div class="panel-body">
	             	<div class="ystep1" style="text-align:center;"></div>                         
	             </div>
	            </div>
	       </div>

        <div class="col-sm-12">
     		<table></table>
        </div>
    </div>
    
    
     <div id="statusInfo" class="hidden">
	    	 <div class="row">
		    	<div class="col-sm-12">
		    		<p>发货人姓名：qqqq</p>
		    		<p>发货区域名称：wwwww</p>
		    	</div>
			</div>
    </div>
                   
</body> 


</html>