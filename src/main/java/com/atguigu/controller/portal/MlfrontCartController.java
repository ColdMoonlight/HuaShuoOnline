package com.atguigu.controller.portal;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.MlfrontCart;
import com.atguigu.bean.MlfrontCartItem;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.MlfrontCartItemService;
import com.atguigu.service.MlfrontCartService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackCart")
public class MlfrontCartController {
	
	@Autowired
	MlfrontCartService mlfrontCartService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	@Autowired
	MlfrontCartItemService mlfrontCartItemService;
	
	/**
	 * 1.0	useOn	0505
	 * 前台购物车列表页面CartPage
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toCartList")
	public String toCartList(HttpServletResponse rep,HttpServletRequest res,HttpSession session) throws Exception{
		
		return "portal/CartOrderPay/cartList";
	}
	
	/**
	 * 2.0	useOn	0505
	 * 前台移动端解算页面mfront/cheakOut
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toCheakOut")
	public String toCheakOut(HttpServletResponse rep,HttpServletRequest res,HttpSession session) throws Exception{
		
		return "portal/CartOrderPay/checkOut";
	}
	
	/**
	 * 3.0	200612
	 * getMlfrontCartByDate
	 * @param mlfrontCart
	 * @return 
	 * */
	@RequestMapping(value="/getMlfrontCartByDate",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlfrontCartByDate(HttpServletResponse rep,HttpServletRequest res,HttpSession session ,@RequestBody MlfrontCart mlfrontCart){
	
		String beginTime = mlfrontCart.getCartCreatetime();
		String endTime = mlfrontCart.getCartMotifytime();
		MlfrontCart mlfrontCartReq = new MlfrontCart();
		mlfrontCartReq.setCartCreatetime(beginTime);
		mlfrontCartReq.setCartMotifytime(endTime);
		List<MlfrontCart> mlfrontCartReqList = mlfrontCartService.selectMlfrontCartByDate(mlfrontCartReq);
		Integer countNumber =mlfrontCartReqList.size();
		return Msg.success().add("countNumber", countNumber).add("resMsg", "加购数查询成功");
	}
	
	/**
	 * 4.0	zsh 200617
	 * 添加产品项进购物车toAddToCart
	 * @param Msg
	 * @return 
	 * */
	@RequestMapping(value="/toAddToCart",method=RequestMethod.POST)
	@ResponseBody
	public Msg toAddToCart(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontCartItem mlfrontCartItem) throws Exception{
		
		//insertAddCartView(mlfrontCartItem,session);
		
		//放回响应域中
		session.setAttribute("mlfrontCartItem", mlfrontCartItem);
		
		String sessionId = session.getId();
		String Userip =sessionId;
		session.setAttribute("Userip", Userip);
		String nowTime = DateUtil.strTime14s();
		MlfrontUser loginUser = (MlfrontUser) session.getAttribute("loginUser");
		//判断session中是否有登录信息 ,if 有，新增进入cart中，没有新增进入
		if(loginUser==null){
			//获取ip信息，去cart中用ip查询，是否有该ip的购物车
			MlfrontCart MlfrontCartReq = new MlfrontCart();
			MlfrontCartReq.setCartIp(Userip);
			MlfrontCartReq.setCartStatus(0);
			List<MlfrontCart> MlfrontCartResList = mlfrontCartService.selectMlfrontCartByIp(MlfrontCartReq);
			Integer ifHave = 1;
			if(MlfrontCartResList.size()>0){
				String cartitemIdstrUser = MlfrontCartResList.get(0).getCartitemIdstr();
				if(cartitemIdstrUser.length()>0){
					ifHave = 1;
				}else{
					//名下有购物车,但是为空
					Integer cartId = MlfrontCartResList.get(0).getCartId();
					MlfrontCart MlfrontCartdelRep = new MlfrontCart();
					MlfrontCartdelRep.setCartId(cartId);
					mlfrontCartService.deleteByPrimaryKey(cartId);
					ifHave = 0;
					//此时要删掉这个为空的购物车
				}
			}else{
				//如果名下没购物车
				ifHave = 0;
			}
			if(ifHave==1){
				//如果有，获取该购物车的itemStr,
				MlfrontCart mlfrontCartUser = MlfrontCartResList.get(0);
				String cartitemIdstrUser = mlfrontCartUser.getCartitemIdstr();
				Integer cartId = mlfrontCartUser.getCartId();
				Integer cartUid = mlfrontCartUser.getCartUid();
				//判断是否有本次添加的产品，如果没有itemStr中加入本次的productId,
				Integer pid = mlfrontCartItem.getCartitemProductId();
				String skuIdstr = mlfrontCartItem.getCartitemProductskuIdstr();
				String skuIdnamestr = mlfrontCartItem.getCartitemProductskuIdnamestr();
				Integer pskuId = mlfrontCartItem.getCartitemProductskuId();
				String pskuName =mlfrontCartItem.getCartitemProductskuName();
				String pskuCode = mlfrontCartItem.getCartitemProductskuCode();
				int proNumberNew =mlfrontCartItem.getCartitemProductNumber();
				String[] aa = cartitemIdstrUser.split(",");
				int number = 0;
				for(int i=0;i<aa.length;i++){
					number++;
					String CartItemId = aa[i];
					Integer CartItemIdInt =Integer.parseInt(CartItemId);
					MlfrontCartItem mlfrontCartItemFor = new MlfrontCartItem();
					mlfrontCartItemFor.setCartitemId(CartItemIdInt);
					mlfrontCartItemFor.setCartitemProductId(pid);
					mlfrontCartItemFor.setCartitemProductskuIdstr(skuIdstr);
					mlfrontCartItemFor.setCartitemProductskuIdnamestr(skuIdnamestr);
					mlfrontCartItemFor.setCartitemProductskuId(pskuId);
					mlfrontCartItemFor.setCartitemProductskuName(pskuName);
					mlfrontCartItemFor.setCartitemProductskuCode(pskuCode);
					//查看该id+该pid+skuIdstr+skuIdnamestr+skuId+skuName+skuCode时候已经有了
					List<MlfrontCartItem> mlfrontCartItemListFor= mlfrontCartItemService.selectMlfrontCartItemOne(mlfrontCartItemFor);
					if(mlfrontCartItemListFor.size()>0){
						//如果存在
						MlfrontCartItem mlfrontCartItemOne = mlfrontCartItemListFor.get(0);
						int ProductNumber = mlfrontCartItemOne.getCartitemProductNumber();
						//该sku的Cartitem的number+1,
						ProductNumber= ProductNumber+proNumberNew;
						mlfrontCartItemOne.setCartitemId(CartItemIdInt);
						mlfrontCartItemOne.setCartitemProductNumber(ProductNumber);
						mlfrontCartItemOne.setCartitemCreatetime(nowTime);
						mlfrontCartItemOne.setCartitemMotifytime(nowTime);
						//更新
						mlfrontCartItemService.updateByPrimaryKeySelective(mlfrontCartItemOne);
						break;
					}else{
						if(number <aa.length){
							continue;
						}else{
							//没有该sku的Cartitem	新增该条Cartitem sku
							//将该id写入cart对象的cartItemStr中
							System.out.println("操作说明：当前客户添加购物车,此前购物车中不包含本次添加的产品"); 
							//将本id加入原来的idstr中
							//更新一下该user的购物车中的cartitemIdstr字段
							mlfrontCartItem.setCartitemStatus(0);
							mlfrontCartItem.setCartitemCreatetime(nowTime);
							mlfrontCartItem.setCartitemMotifytime(nowTime);
//							Integer accoff =  mlfrontCartItem.getCartitemProductActoff();
//							mlfrontCartItem.setCartitemProductActoff(accoff*10);
							mlfrontCartItemService.insertSelective(mlfrontCartItem);
							Integer cartItemId = mlfrontCartItem.getCartitemId();
							String cartItemIdStrnew = cartItemId+"";
							cartitemIdstrUser=cartitemIdstrUser+","+cartItemIdStrnew;
							MlfrontCart mlfrontCartAfter = new MlfrontCart();
							mlfrontCartAfter.setCartId(cartId);
							mlfrontCartAfter.setCartUid(cartUid);
							mlfrontCartAfter.setCartitemIdstr(cartitemIdstrUser);
							mlfrontCartAfter.setCartMotifytime(nowTime);
							mlfrontCartService.updateByPrimaryKeySelective(mlfrontCartAfter);
							//将本mlfrontCartItem插入mlfrontCartItem表中
							//更新本条cartitem,
							mlfrontCartItem.setCartitemId(cartItemId);
							mlfrontCartItem.setCartitemCartId(cartId);
							mlfrontCartItemService.updateByPrimaryKeySelective(mlfrontCartItem);
							break;
						}
					}
				}
			}else{
				//这个ip没来过，直接新增一条即可mlfrontCartItem，将主键放入cart对象中，之后在新增该对象cart
				mlfrontCartItem.setCartitemCreatetime(nowTime);
				mlfrontCartItem.setCartitemMotifytime(nowTime);
				mlfrontCartItem.setCartitemStatus(0);
				mlfrontCartItemService.insertSelective(mlfrontCartItem);
				Integer cartItemId = mlfrontCartItem.getCartitemId();
				//拿回来主键ID		mlfrontCartItem
				MlfrontCart MlfrontCartItemReturn = new MlfrontCart();
				String cartItemIdStr = cartItemId+"";
				MlfrontCartItemReturn.setCartitemIdstr(cartItemIdStr);
				MlfrontCartItemReturn.setCartIp(Userip);
				MlfrontCartItemReturn.setCartStatus(0);
				MlfrontCartItemReturn.setCartCreatetime(nowTime);
				MlfrontCartItemReturn.setCartMotifytime(nowTime);
				//折扣*10
				Integer accoff =  mlfrontCartItem.getCartitemProductActoff();
				mlfrontCartItem.setCartitemProductActoff(accoff);//	拿到的就是真实的折扣
				mlfrontCartService.insertSelective(MlfrontCartItemReturn);
				
				Integer cartAfterId = MlfrontCartItemReturn.getCartId();
				mlfrontCartItem.setCartitemId(cartItemId);
				mlfrontCartItem.setCartitemCartId(cartAfterId);
				mlfrontCartItemService.updateByPrimaryKeySelective(mlfrontCartItem);
			}
		}else{
			//获取uid信息，去cart中用uid查询，是否有该uid的购物车
			MlfrontCart MlfrontCartReq = new MlfrontCart();
			Integer uid =loginUser.getUserId();
			MlfrontCartReq.setCartUid(uid);
			MlfrontCartReq.setCartStatus(0);
			List<MlfrontCart> MlfrontCartResList = mlfrontCartService.selectMlfrontCartByUidAndStatus(MlfrontCartReq);
			Integer ifHave = 1;
			if(MlfrontCartResList.size()>0){
				String cartitemIdstrUser = MlfrontCartResList.get(0).getCartitemIdstr();
				if(cartitemIdstrUser.length()>0){
					ifHave = 1;
				}else{
					//名下有购物车,但是为空
					Integer cartId = MlfrontCartResList.get(0).getCartId();
					MlfrontCart MlfrontCartdelRep = new MlfrontCart();
					MlfrontCartdelRep.setCartId(cartId);
					mlfrontCartService.deleteByPrimaryKey(cartId);
					ifHave = 0;
					//此时要删掉这个为空的购物车
				}
			}else{
				//如果名下没购物车
				ifHave = 0;
			}
			if(ifHave==1){
				//如果有，获取该购物车的itemStr,
				MlfrontCart mlfrontCartUser = MlfrontCartResList.get(0);
				String cartitemIdstrUser = mlfrontCartUser.getCartitemIdstr();
				Integer cartId = mlfrontCartUser.getCartId();
				Integer cartUid = mlfrontCartUser.getCartUid();
				//判断是否有本次添加的产品，如果没有itemStr中加入本次的productId,
				Integer pid = mlfrontCartItem.getCartitemProductId();
				String skuIdstr = mlfrontCartItem.getCartitemProductskuIdstr();
				String skuIdnamestr = mlfrontCartItem.getCartitemProductskuIdnamestr();
				Integer pskuId = mlfrontCartItem.getCartitemProductskuId();
				String pskuName =mlfrontCartItem.getCartitemProductskuName();
				String pskuCode = mlfrontCartItem.getCartitemProductskuCode();
				int proNumberNew =mlfrontCartItem.getCartitemProductNumber();
				//String pidStr = pid+"";
				String[] aa = cartitemIdstrUser.split(",");
				int number = 0;
				for(int i=0;i<aa.length;i++){
					number++;
					String CartItemId = aa[i];
					Integer CartItemIdInt =Integer.parseInt(CartItemId);
					MlfrontCartItem mlfrontCartItemFor = new MlfrontCartItem();
					mlfrontCartItemFor.setCartitemId(CartItemIdInt);
					mlfrontCartItemFor.setCartitemProductId(pid);
					mlfrontCartItemFor.setCartitemProductskuIdstr(skuIdstr);
					mlfrontCartItemFor.setCartitemProductskuIdnamestr(skuIdnamestr);
					mlfrontCartItemFor.setCartitemProductskuId(pskuId);
					mlfrontCartItemFor.setCartitemProductskuName(pskuName);
					mlfrontCartItemFor.setCartitemProductskuCode(pskuCode);
					//查看该id+该pid+skuIdstr+skuIdnamestr+skuNamestr时候已经有了
					List<MlfrontCartItem> mlfrontCartItemListFor= mlfrontCartItemService.selectMlfrontCartItemOne(mlfrontCartItemFor);
					if(mlfrontCartItemListFor.size()>0){
						//如果存在
						MlfrontCartItem mlfrontCartItemOne = mlfrontCartItemListFor.get(0);
						int ProductNumber = mlfrontCartItemOne.getCartitemProductNumber();
						//该sku的Cartitem的number+1,
						ProductNumber= ProductNumber+proNumberNew;
						mlfrontCartItemOne.setCartitemId(CartItemIdInt);
						mlfrontCartItemOne.setCartitemProductNumber(ProductNumber);
						mlfrontCartItemOne.setCartitemCreatetime(nowTime);
						mlfrontCartItemOne.setCartitemMotifytime(nowTime);
						//更新
						mlfrontCartItemService.updateByPrimaryKeySelective(mlfrontCartItemOne);
						break;
					}else{
						if(number <aa.length){
							continue;
						}else{
							//没有该sku的Cartitem
							//新增该条Cartitem sku
							//将该id写入cart对象的cartItemStr中
							System.out.println("操作说明：当前客户添加购物车,此前购物车中不包含本次添加的产品"); 
							//将本id加入原来的idstr中
							//更新一下该user的购物车中的cartitemIdstr字段
							mlfrontCartItem.setCartitemStatus(0);
							mlfrontCartItem.setCartitemCreatetime(nowTime);
							mlfrontCartItem.setCartitemMotifytime(nowTime);
							//折扣*10
							Integer accoff =  mlfrontCartItem.getCartitemProductActoff();
							mlfrontCartItem.setCartitemProductActoff(accoff*10);
							mlfrontCartItemService.insertSelective(mlfrontCartItem);
							
							Integer cartItemId = mlfrontCartItem.getCartitemId();

							String cartItemIdStrnew = cartItemId+"";
							cartitemIdstrUser=cartitemIdstrUser+","+cartItemIdStrnew;
							MlfrontCart mlfrontCartAfter = new MlfrontCart();
							mlfrontCartAfter.setCartId(cartId);
							mlfrontCartAfter.setCartUid(cartUid);
							mlfrontCartAfter.setCartitemIdstr(cartitemIdstrUser);
							mlfrontCartAfter.setCartMotifytime(nowTime);
							mlfrontCartService.updateByPrimaryKeySelective(mlfrontCartAfter);
							//将本mlfrontCartItem插入mlfrontCartItem表中
							//更新本条cartitem,
							mlfrontCartItem.setCartitemId(cartItemId);
							mlfrontCartItem.setCartitemCartId(cartId);
							mlfrontCartItemService.updateByPrimaryKeySelective(mlfrontCartItem);
							break;
						}
					}
				}
			}else{
				//这个ip没来过，直接新增一条即可mlfrontCartItem，将主键放入cart对象中，之后在新增该对象cart
				mlfrontCartItem.setCartitemCreatetime(nowTime);
				mlfrontCartItem.setCartitemMotifytime(nowTime);
				mlfrontCartItem.setCartitemStatus(0);
				//折扣*10
				Integer accoff =  mlfrontCartItem.getCartitemProductActoff();
				mlfrontCartItem.setCartitemProductActoff(accoff*10);
				mlfrontCartItemService.insertSelective(mlfrontCartItem);
				
				Integer cartItemId = mlfrontCartItem.getCartitemId();

				//拿回来主键ID		mlfrontCartItem
				MlfrontCart MlfrontCartItemReturn = new MlfrontCart();
				String cartItemIdStr = cartItemId+"";
				MlfrontCartItemReturn.setCartitemIdstr(cartItemIdStr);
				MlfrontCartItemReturn.setCartUid(uid);
				MlfrontCartItemReturn.setCartStatus(0);
				MlfrontCartItemReturn.setCartCreatetime(nowTime);
				MlfrontCartItemReturn.setCartMotifytime(nowTime);
				mlfrontCartService.insertSelective(MlfrontCartItemReturn);
				
				Integer cartAfterId = MlfrontCartItemReturn.getCartId();

				mlfrontCartItem.setCartitemId(cartItemId);
				mlfrontCartItem.setCartitemCartId(cartAfterId);
				mlfrontCartItemService.updateByPrimaryKeySelective(mlfrontCartItem);
			}
		}
		return Msg.success().add("resMsg", "添加成功");
	}
	
	/**5.0	zsh 200617
	 * getCartProductNumber	POST
	 * @param 
	 */
	@RequestMapping(value="/getCartProductNumber",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCartProductNumber(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		String sessionId = session.getId();
		MlfrontUser loginUser = (MlfrontUser) session.getAttribute("loginUser");
		//判断session中是否有登录信息 ,if 有，新增进入cart中，没有新增进入
		int number = 0;
		String Userip =sessionId;
		MlfrontCart MlfrontCartReq = new MlfrontCart();
		MlfrontCartReq.setCartStatus(0);
		if(loginUser==null){
			MlfrontCartReq.setCartIp(Userip);
			//查询是否有生效中的购物车
			List<MlfrontCart> mlfrontCartResList = mlfrontCartService.selectMlfrontCartByIp(MlfrontCartReq);
			if(mlfrontCartResList.size()>0){
				String cartitemIdStr = mlfrontCartResList.get(0).getCartitemIdstr();
				if(cartitemIdStr.length()>0){
					String[] aa = cartitemIdStr.split(",");
					number=aa.length;
				}
				//System.out.println(number);
			}else{
				number = 0;
			}
		}else{
			Integer uid = loginUser.getUserId();
			MlfrontCartReq.setCartUid(uid);
			//查询是否有生效中的购物车
			List<MlfrontCart> mlfrontCartResList = mlfrontCartService.selectMlfrontCartByUidAndStatus(MlfrontCartReq);
			if(mlfrontCartResList.size()>0){
				String cartitemIdStr = mlfrontCartResList.get(0).getCartitemIdstr();
				if(cartitemIdStr.length()>0){
					String[] aa = cartitemIdStr.split(",");
					number=aa.length;
				}
				//System.out.println(number);
			}else{
				number = 0;
			}
		}
		return Msg.success().add("resMsg", "更新成功").add("number", number);
	}
	
	/**6.0	zsh 200617
	 * getCartitemIdDetails	get
	 * @param
	 */
	@RequestMapping(value="/getCartitemIdDetails",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCartitemIdDetails(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		String sessionId = session.getId();
		String Userip =sessionId;
		MlfrontUser loginUser = (MlfrontUser) session.getAttribute("loginUser");
		MlfrontCart MlfrontCartReq = new MlfrontCart();
		MlfrontCartReq.setCartStatus(0);
		List<MlfrontCart> mlfrontCartResList = new ArrayList<MlfrontCart>();
		if(loginUser==null){
			MlfrontCartReq.setCartIp(Userip);
			mlfrontCartResList = mlfrontCartService.selectMlfrontCartByIp(MlfrontCartReq);
		}else{
			Integer Uid = loginUser.getUserId();
			MlfrontCartReq.setCartUid(Uid);
			mlfrontCartResList = mlfrontCartService.selectMlfrontCartByUidAndStatus(MlfrontCartReq);
		}
		String cartitemIdStr = mlfrontCartResList.get(0).getCartitemIdstr();
		String[] aa = cartitemIdStr.split(",");
		List<MlfrontCartItem> mlfrontCartItemListRes = new ArrayList<MlfrontCartItem>();
		for(int i=0;i<aa.length;i++){
			String CartItemId = aa[i];
			Integer CartItemIdInt =Integer.parseInt(CartItemId);
			MlfrontCartItem mlfrontCartItemFor = new MlfrontCartItem();
			mlfrontCartItemFor.setCartitemId(CartItemIdInt);
			//查看该id+该pid时候已经有了
			List<MlfrontCartItem> mlfrontCartItemListFor= mlfrontCartItemService.selectMlfrontCartItemById(mlfrontCartItemFor);
			if(mlfrontCartItemListFor.size()>0){
				mlfrontCartItemListRes.add(mlfrontCartItemListFor.get(0));
			}
		}
		return Msg.success().add("resMsg", "更新成功").add("mlfrontCartItemListRes", mlfrontCartItemListRes);
	}
	
	/**
	 * 7.0	zsh 190615
	 * 删除购物车中的项delCartItem
	 * @param Msg
	 * @return 
	 * */
	@RequestMapping(value="/delCartItem",method=RequestMethod.POST)
	@ResponseBody
	public Msg delCartItem(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontCartItem mlfrontCartItem) throws Exception{
		//接收传递进来的参数
		Integer cartItemIdOriginal = mlfrontCartItem.getCartitemId();
		int isDelSuccess = 0;
		if(cartItemIdOriginal==null){
			return Msg.success().add("resMsg", "删除失败，主建为null，请联系管理员").add("isDelSuccess", isDelSuccess);//isDelSuccess0删除失败，alert	resMsg/1,删除成功
		}else{
			//通过cartitem的之间查回该条信息，从中取出cartId
			MlfrontCartItem mlfrontCartItemReqq  =new MlfrontCartItem();
			mlfrontCartItemReqq.setCartitemId(cartItemIdOriginal);
			List<MlfrontCartItem> mlfrontCartItemRessList = mlfrontCartItemService.selectMlfrontCartItemById(mlfrontCartItemReqq);
			if(mlfrontCartItemRessList.size()>0){
				Integer cartId = mlfrontCartItemRessList.get(0).getCartitemCartId();
				String cartItemIdOriginalStr = cartItemIdOriginal+"";
				String nowTime = DateUtil.strTime14s();
				MlfrontCart MlfrontCartReq = new MlfrontCart();
				MlfrontCartReq.setCartId(cartId);
				MlfrontCart mlfrontCartRes  = mlfrontCartService.selectMlfrontCartByCartId(cartId);
				//1根据cart该购物车中的本条cartItemStr中的字段
				String cartitemIdstr = mlfrontCartRes.getCartitemIdstr();
				String cartItemArr[] =cartitemIdstr.split(",");
				String cartitemStrEnd = "";
				if(cartItemArr.length>1){
					//1.1如果有多个删除字段中的该项
					for(int i =0;i<cartItemArr.length;i++){
						String tem = cartItemArr[i];
						if(tem.equals(cartItemIdOriginalStr)){
							continue;
						}else{
							cartitemStrEnd=cartitemStrEnd+tem+",";
						}
					}
					int lastIN = cartitemStrEnd.length();
					cartitemStrEnd = cartitemStrEnd.substring(0, (lastIN-1));
					//更新cart中的cartitemStr字段
					MlfrontCart mlfrontCartreqE = new MlfrontCart();
					mlfrontCartreqE.setCartId(cartId);
					mlfrontCartreqE.setCartitemIdstr(cartitemStrEnd);
					mlfrontCartreqE.setCartMotifytime(nowTime);
					mlfrontCartService.updateByPrimaryKeySelective(mlfrontCartreqE);
				}else{
					//1.2如果只有一个，删掉购物车
					mlfrontCartService.deleteByPrimaryKey(cartId);
				}
				//2删除该条CartItem信息
				mlfrontCartItemService.deleteByPrimaryKey(cartItemIdOriginal);
				isDelSuccess = 1;
				return Msg.success().add("resMsg", "删除成功").add("isDelSuccess", isDelSuccess);//isDelSuccess0删除失败，alert	resMsg/1,删除成功
			}else{
				return Msg.success().add("resMsg", "删除失败，该cartitem项不存在，请联系管理员").add("isDelSuccess", isDelSuccess);//isDelSuccess0删除失败，alert	resMsg/1,删除成功
			}
		}			
	}
	
	/**
	 * 8.0	zsh 190624
	 * 添加产品项进购物车updateCartItemSkuNum
	 * @param
	 * @return Msg
	 * */
	@RequestMapping(value="/updateCartItemSkuNum",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateCartItemSkuNum(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontCartItem mlfrontCartItem) throws Exception{
		//接收传递进来的参数
		Integer cartItemIdOriginal = mlfrontCartItem.getCartitemId();
		Integer number = mlfrontCartItem.getCartitemProductNumber();
		
		MlfrontCartItem MlfrontCartItemUpdate = new MlfrontCartItem();
		MlfrontCartItemUpdate.setCartitemId(cartItemIdOriginal);
		MlfrontCartItemUpdate.setCartitemProductNumber(number);
		String nowTime = DateUtil.strTime14s();
		MlfrontCartItemUpdate.setCartitemMotifytime(nowTime);
		//2删除该条CartItem信息
		mlfrontCartItemService.updateByPrimaryKeySelective(MlfrontCartItemUpdate);
		
		return Msg.success().add("resMsg", "mlfrontCartItemUpdate successful");
	}
	
}
