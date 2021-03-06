<!DOCTYPE html>
<html> 
<head> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>资源管理</title> 
    <link rel="shortcut icon" href="favicon.ico">
	<#import "/common/import.ftl" as import>
    <@import.tableManagerImportCss/> 
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        

        <!-- Panel Other -->
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>资源管理</h5>
                <div class="ibox-tools"> 
                    
                </div>
            </div>
            <div class="ibox-content">
                <div class="row row-lg">  
                    <div class="col-sm-12">
                        <!-- Example Events -->
                        <div class="example-wrap"> 
                            <div class="example"> 
                                <div class="btn-group hidden-xs" id="exampleTableEventsToolbar" role="group">
                                    <button type="button" class="btn btn-outline btn-default" data-toggle="modal" id="addRes" data-target="#userModal">
                                        <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>&nbsp;&nbsp;新增
                                    </button>
                                    <button type="button" class="btn btn-outline btn-default" id="updateRes" >
                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>&nbsp;&nbsp;修改
                                    </button>
                                     
                                    <button type="button" class="btn btn-outline btn-default" id="delRes">
                                        <i class="glyphicon glyphicon-trash" aria-hidden="true"></i>&nbsp;&nbsp;删除
                                    </button>   
                                </div>
                                <table id="resourceTableEvents"   data-mobile-responsive="true" >
                                    <thead>
                                        <tr>
                                            <th data-field="state" data-radio="true"></th>  
                                            <th data-field="id"  data-visible="false" >id</th>  
								            <th data-field="name" >名称</th>  
								            <th data-field="url"  >链接</th> 
								            <th data-field="companyTypeName" data-formatter="formatterTypeName" >所属类型</th>
								            <th data-field="remark"  >备注</th>   
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
	<div id="win_edit"></div> 
    
    <@import.tableManagerImportScript/> 
    <script >
    	//设置传入参数
		function queryParams(params) {
		  return params
		}
		$(window).resize(function () {
		        $('#resourceTableEvents').bootstrapTable('resetView');
		});
    	//加载用户table数据
    	$(function(){ 
	    	$("#resourceTableEvents").bootstrapTable({
	            url: "${WEB_PATH }/system/resource/getPage.do",
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
	            minimumCountColumns: 1,  
	            showToggle:false, 
	            clickToSelect: true,  
	            icons: {
	                refresh: "glyphicon-repeat", 
	                columns: "glyphicon-list"
	            }
	        });
	        
	        $('input.form-control.input-outline').attr("placeholder","请输入资源名称"); //设置搜索提示信息
	        
	        //删除用户
	        $('#delRes').click(function () {
	        	var selectRow = $("#resourceTableEvents").bootstrapTable('getSelections');
	        	if(0 == selectRow.length){
				    swal({
				        title: "请选择要删除的资源",
				        text: "请选中需要删除的资源，再使用删除操作。"
				    })
				    return ;
	        	}
	        	var userIds = "";
	        	for(var i=0;i<selectRow.length;i++){
	        		userIds +=  selectRow[i].id +",";
				}
			    swal({
			        title: "您确定要删除该资源吗",
			        text: "删除后将无法恢复，请谨慎操作！",
			        type: "warning",
			        showCancelButton: true,
			        confirmButtonColor: "#DD6B55",
			        confirmButtonText: "是的，我要删除！",
			        cancelButtonText: "让我再考虑一下…",
			        closeOnConfirm: false,
			        closeOnCancel: false
			    },
			    function(isConfirm) {
			        if (isConfirm) { 
						$.yilinAjax({
					   	  	type:'POST',
					   	  	url:'${WEB_PATH }/system/resource/remove.do?resourceId=' + userIds,
					   	  	data:null,
		            		errorcallback:null,
		            		successcallback:success
				   	    });
			        } else {
			            swal("已取消", "您取消了删除操作！", "error")
			        }
			    })
			});
        });
        //修改用户    data-toggle="modal" data-target="#userModal"  aria-hidden="true"
        $("#updateRes").click(function(){
        	var selectRow = $("#resourceTableEvents").bootstrapTable('getSelections');
	        if(1 != selectRow.length){
			    swal({
			        title: "选择修改资源操作错误",
			        text: "请选择一行您要修改的资源信息，一次有且只有一个资源信息。"
			    })
			    return ;
	       	}
	       	var res = selectRow[0];  
	       	$("#win_edit").load("${WEB_PATH }/system/resource/view/edit.do?resourceId="+res.id);
        });
        
        //加载添加页面
        $('#addRes').click(function(){
        	$("#win_add").load("${WEB_PATH }/system/resource/view/add.do");
        });
        
        function success(result) {
			var data = $.parseJSON(result);
			if(data.success == true){
				swal("删除成功！", "您已经永久删除了该资源。", "success")
				$("#resourceTableEvents").bootstrapTable('refresh');
			}else{
				swal("删除失败！", data.msg, "error")
			}
		}
        
        function formatterTypeName(index, row, element){ 
        	var typeName = '<span class="label label-primary">'+row.companyType.name+'</span>';
        	return typeName;
		} 
    </script>
</body>

</html>