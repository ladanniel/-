
<div class="modal inmodal" id="userModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: block; padding-left: 6px;">
        <div class="modal-dialog" style="width:70%;">
            <div class="modal-content animated bounceInRight">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" style="margin-top: -20px;"><span aria-hidden="true" id="close-x">&times;</span><span class="sr-only" >关闭</span>
                    </button>
                    <h1 class="modal-title">[${account.name!}]---用户信息</h1>
                    <div class="modal-body" style="max-height:450px;overflow-y: auto;"> 
                       <#if account.authentication != "notapply">
						  	<div class="row" >
							  	<div class="col-sm-12">
							        <div class="tabs-container">
							            <ul class="nav nav-tabs"> 
							            	<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">用户信息</a> </li>
							            	<#if role.is_aut == true>
										  		<#if role.idcard == true && account.idcard_id != ""  >
												<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">身份证信息
												<#if account.aut_supplement_type?? && account.aut_supplement_type?index_of("idcard")!=-1>
													<span class="label label-danger">补录信息</span>
												</#if>
												</a> </li>
												</#if>
												<#if role.driving_license == true &&  account.driving_license_id != "">
												<li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">驾驶证信息
												<#if account.aut_supplement_type?? && account.aut_supplement_type?index_of("driving")!=-1>
													<span class="label label-danger">补录信息</span>
												</#if>
												</a> </li>
												</#if>
											</#if> 
							            </ul>
							            <div class="tab-content">
							            		 <div id="tab-1" class="tab-pane active">
								                    <div class="ibox-content">
								                    	<div class="row yico" style="font-size:18px;">
								                            <div class="col-sm-5">
								                                <dl class="dl-horizontal">
								                                	<dt style="background: url('${WEB_PATH}/resources/img/icon/account_img.png') no-repeat 0 0;background-size: 25px;">帐号：</dt>
								                                    <dd>${account.account}<input id="account_id" type="hidden"  class="form-control" value="${account.id!}" ></dd>
								
								                                    <dt style="background: url('${WEB_PATH}/resources/img/icon/status_img.png') no-repeat 0 0;background-size: 25px;">启用状态：</dt>
								                                    <dd>
								                                    	<#if account.status == 1 >
								                                    		<span class="label label-danger">关闭</span>
								                                    	<#else>
								                                    		<span class="label label-primary">启用</span>
								                                    	</#if>
								                                    </dd>
								                                    <dt style="background: url('${WEB_PATH}/resources/img/icon/ip_img.png') no-repeat 0 0;background-size: 25px;" >登陆ip：</dt>
								                                    <dd>${((account.login_ip)?? && USER.login_ip != '')?string(USER.login_ip,'<span class="label label-danger">无</span>')}</dd>
								                                    <dt style="background: url('${WEB_PATH}/resources/img/icon/count_img.png') no-repeat 0 0;background-size: 25px;">登陆次数：</dt>
								                                    <dd>${((account.login_count)?? && account.login_count != 0)?string(account.login_count+"次",'<span class="label label-danger">无</span>')}</dd>
								                                    <dt  style="background: url('${WEB_PATH}/resources/img/icon/phone_img.png') no-repeat 0 0;background-size: 25px;">绑定手机：</dt>
								                                    <dd>
																		 ${account.phone}
																	</dd>
								                                </dl>
								                            </div>
								                            <div class="col-sm-7" id="cluster_info">
								                                <dl class="dl-horizontal">
								
								                                    <dt  style="background: url('${WEB_PATH}/resources/img/icon/time_img.png') no-repeat 0 0;background-size: 25px;">注册时间：</dt>
								                                    <dd>
								                                    	<#if account.create_time?? >
								                                    		${(account.create_time)!?string("yyyy-MM-dd")!}
								                                    	<#else>
								                                    		<span class="label label-danger">无</span>
								                                    	</#if>
								                                    </dd>
								                                    <dt  style="background: url('${WEB_PATH}/resources/img/icon/dept_img.png') no-repeat 0 0;background-size: 25px;">所属部门：</dt>
								                                    <dd>${((account.companySection.name)?? && account.companySection.name != '')?string(account.companySection.name,'<span class="label label-danger">无</span>')}</dd>
								                                    <dt  style="background: url('${WEB_PATH}/resources/img/icon/role_img.png') no-repeat 0 0;background-size: 25px;">角色名称：</dt>
								                                    <dd>
								                                    	${((account.role.name)?? && account.role.name != '')?string(account.role.name,'<span class="label label-danger">无</span>')}
								                                    </dd>
								                                    <dt style="background: url('${WEB_PATH}/resources/img/icon/role_img.png') no-repeat 0 0;background-size: 25px;">认证状态：</dt>
								                                    <dd>
								                                    	<#if account.authentication == "notapply">
											                           	 	<span class="label label-danger"><i class="fa fa-close"></i>&nbsp;&nbsp;未提交认证审核</span>
											                            </#if>
								                                        <#if account.authentication == "waitProcess">
											                           	 	<span class="label label-primary"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;等待审核</span>
											                            </#if>
											                            <#if account.authentication == "notAuth">
											                            	<span class="label label-danger"><i class="fa fa-close"></i>&nbsp;&nbsp;审核未通过</span>
											                            </#if>
											                            <#if account.authentication == "auth">
											                            	<span class="label label-success"><i class="fa fa-truck"></i>&nbsp;&nbsp;审核通过</span>
											                            </#if>
											                            <#if account.authentication == "supplement">
											                            	<span class="label"><i class="fa fa-edit"></i>&nbsp;&nbsp;认证信息补录</span>;
											                            </#if> 
											                            <#if account.authentication == "waitProcessSupplement">
											                            	<span class="label"><i class="fa fa-edit"></i>&nbsp;&nbsp;补录等待审核</span>;
											                            </#if> 
								                                    </dd>
								                                </dl>
								                            </div>
								                        </div>
							                        </div>
								                </div>
								                <#if role.is_aut == true>
								                <#if role.idcard == true && account.idcard_id != "">
								                <div id="tab-2" class="tab-pane">
								                    <div class="ibox-content">
								                    	<div class="row" style="font-size: 16px;">
									                        <div  class="col-sm-6" style="padding-left: 15%;">
									                            <p><i class="fa green fa-user"></i> <strong>姓名：</strong><span>${idcard.name!}</span></p>
								                            </div>
								                            <div  class="col-sm-6" style="padding-left: 15%;">
									                            <p><i class="fa green fa-credit-card"></i> <strong>身份证号码：</strong><span>${idcard.idcard_no!}</span></p>
								                            </div>
								                            <div class="col-sm-12">
								                                <div class="col-sm-4">
								                                	<div class="form-group">
									                                    <div class="panel panel-primary" id="idcard_front_img_view_panel">
										                                    <div class="panel-heading">
										                                      	身份证正面
										                                    </div>
										                                    <div class="panel-body">
										                                    	<div >
										                                    		 <div >
										                                    		 	<a class="fancybox" href="${idcard.idcard_front_img!}" title="身份证反面">
											                                         	<img id="idcard_front_img_view" src="${idcard.idcard_front_img!}" style="width: 100%;border: 1px solid #e5e6e7;">
											                                         	</a>
											                                         </div>
												                                </div>
										                                    </div>
										                                </div>
									                                </div>
								                            	</div>
								                            	<div class="col-sm-4">
								                                	<div class="form-group">
									                                    <div class="panel panel-primary" id="idcard_back_img_view_panel">
										                                    <div class="panel-heading">
										                                      	身份证反面
										                                    </div>
										                                    <div class="panel-body">
										                                    	<div>
											                                         <div >
											                                         	<a class="fancybox" href="${idcard.idcard_back_img!}" title="身份证反面">
											                                         	<img id="idcard_back_img_view" src="${idcard.idcard_back_img!}" style="width: 100%;border: 1px solid #e5e6e7;">
											                                         	</a>
											                                         </div>
												                                </div>
										                                    </div>
										                                </div>
									                                </div>
								                            	</div>
								                            	<div class="col-sm-4">
								                                	<div class="form-group">
									                                    <div class="panel panel-primary" id="idcard_persoin_img_view_panel">
										                                    <div class="panel-heading">
										                                      	手持身份证照片
										                                    </div>
										                                    <div class="panel-body">
										                                    	<div>
										                                    		 <div >
										                                    		 	<a class="fancybox" href="<#if idcard.idcard_persoin_img?? && autinfo.idcard.idcard_persoin_img != "">${WEB_PATH}/resources/img/img_no.jpg<#else>${idcard.idcard_persoin_img}</#if>" title="手持身份证照片">
											                                         	<img id="idcard_persoin_img_view" src="<#if idcard.idcard_persoin_img?? && autinfo.idcard.idcard_persoin_img != "">${WEB_PATH}/resources/img/img_no.jpg<#else>${idcard.idcard_persoin_img}</#if>" style="width: 100%;border: 1px solid #e5e6e7;">
											                                         	</a>
											                                         </div>
												                                </div>
										                                    </div>
										                                </div>
									                                </div>
								                            	</div>
								                            </div>
							                            </div>
							                        </div>
								                </div>
								                </#if>
								                <#if role.driving_license == true && account.driving_license_id != "">
								                <div id="tab-3" class="tab-pane">
								                    <div class="ibox-content">
								                    	<div class="row" style="font-size: 16px;">
									                        <div  class="col-sm-4" style="padding-left: 3%;">
									                            <p><i class="fa green fa-user"></i> <strong>驾驶证姓名：</strong><span>${drivingLicense.name!}</span></p>
									                            <p><i class="fa green fa-credit-card"></i> <strong>驾驶证编号：</strong><span>${drivingLicense.driving_license_no!}</span></p>
								                            </div>
								                             <div  class="col-sm-4" style="padding-left: 3%;">
									                            <p><i class="fa green fa-intersex"></i> <strong>性别：</strong><span>${(drivingLicense.sex == 1)?string('男','女')}</span></p>
									                            <p><i class="fa green fa-truck"></i> <strong> 准驾车型：</strong><span class="label label-success" ><i class="fa fa-truck"></i>&nbsp;${drivingLicense.drivingLicenseType.no!}</span></p>
								                            </div>
								                            <div  class="col-sm-4" style="padding-left: 3%;">
									                            <p><i class="fa green fa-calendar"></i> <strong>有效起始日期：</strong><span>${drivingLicense.valid_start_date!}</span></p>
									                            <p><i class="fa green fa-calendar"></i> <strong>有效年限：</strong><span>${drivingLicense.valid_year!}</span></p>
								                            </div>
								                            <div  class="col-sm-12" style="padding-left: 3%;">
								                            	<p><i class="fa green fa-map-marker" style="font-size: 23px;"></i><strong>地址：</strong><span>${drivingLicense.address!}</span></p>
								                            </div>
								                            <div class="col-sm-12">
								                                <div class="col-sm-4">
								                                	<div class="form-group">
									                                    <div class="panel panel-primary" id="idcard_front_img_view_panel">
										                                    <div class="panel-heading">
										                                      	驾驶证图片
										                                    </div>
										                                    <div class="panel-body">
										                                    	<div >
										                                    		 <div >
										                                    		 	<a class="fancybox" href="${drivingLicense.driving_license_img!}" title="驾驶证图片">
											                                         	<img id="idcard_front_img_view" src="${drivingLicense.driving_license_img!}" style="width: 100%;border: 1px solid #e5e6e7;">
											                                         	</a>
											                                         </div>
												                                </div>
										                                    </div>
										                                </div>
									                                </div>
								                            	</div>
								                            </div>
							                            </div>
							                        </div>
								                </div>
								               </#if>
							                </#if>
							            </div>
							        </div>
							    </div>
							</div>
						</#if>
                    </div>
                </div>
            </div>
        </div> 
    </div>
 <script>
 $(function(){ 
 	 $(".fancybox").fancybox({openEffect:"none",closeEffect:"none"}); 
    $('#close-x').click(function(){
   		$('#userModal').remove();
    }); 
});
 
  </script>   
