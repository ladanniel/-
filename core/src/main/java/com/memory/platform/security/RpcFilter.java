package com.memory.platform.security;

import com.alibaba.dubbo.rpc.Filter;
import com.alibaba.dubbo.rpc.Invocation;
import com.alibaba.dubbo.rpc.Invoker;
import com.alibaba.dubbo.rpc.Result;
import com.alibaba.dubbo.rpc.RpcContext;
import com.alibaba.dubbo.rpc.RpcException;
import com.memory.platform.core.AppUtil;
import com.memory.platform.entity.member.Account;

 
/*
 * 消费者拦截器
 * */
public class RpcFilter  implements Filter{

	@Override
	public Result invoke(Invoker<?> invoker, Invocation invocation)
			throws RpcException {
		Account account = AppUtil.getLoginUser();
		if(account!=null) {
			RpcContext.getContext().setAttachment("tokenID", account.getToken());
		}
				
		return invoker.invoke(invocation);
	}

}
